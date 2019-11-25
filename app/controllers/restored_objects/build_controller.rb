class RestoredObjects::BuildController < ApplicationController
  include Wicked::Wizard

  steps :basic_info, :classify, :upload, :pieces, :details

  def show
    @object = RestoredObject.find(params[:restored_object_id])
    render_wizard
  end


  def update
    @object = RestoredObject.find(params[:restored_object_id])
    params[:restored_object][:current_step] = step.to_s
    params[:restored_object][:current_step] = 'active' if step == steps.last

    @object.update_attributes(build_params)
    if params[:zip_file]
      params[:pieces_attributes] = nil
      if params[:zip_file].content_type != 'application/zip'
        flash[:danger] = "Attached file must be a zip"
        redirect_to request.referrer
        return
      else
        Zip::File.open(params[:zip_file].path) do |zipfile|
          zipfile.glob('*{ply,stl,obj}') do |file|
              matrix_file = zipfile.glob("#{file.name.downcase.split('.').first}.txt").first
              if matrix_file
                matrix = matrix_file.get_input_stream.read
              else
                matrix = ""
              end
              
              piece = @object.pieces.build(name: file.name, matrix: matrix)
              piece.model.attach(io: StringIO.new(file.get_input_stream.read), filename: file.name)
              material_file = zipfile.glob("#{file.name.split('.').first}.mtl").first
              temp_material_text = StringIO.new(material_file.get_input_stream.read).string
              image_files = zipfile.entries.keep_if { |file| /\.(png|jpg|jpeg|bmp)$/i =~ file.name.downcase }

              image_files.each do |image|
                piece.images.attach(io: StringIO.new(image.get_input_stream.read), filename: image.name)
                
                temp_material_text.gsub!(image.name, piece.images.last.service_url.split("?")&.first)
              end

              piece.material.attach(io: StringIO.new(temp_material_text), filename: material_file.name)
          end
        end
      end
    end
    render_wizard @object
  end


  def create
    @object = RestoredObject.create
    redirect_to wizard_path(steps.first, :restored_object_id => @object.id)
  end

  private
  def build_params
    params.require(:restored_object).permit(:title, :description, :notes,
      :classification, :author, :epoch, :avatar, :current_step,
      :width, :height, :depth, :units_id, :state_id, :protection_id,
      :technique, :decoration, :owner, :deposit,
      :address, :longitude, :latitude, :in_inventory,
      :inventory_no, :priority_id, :zip_file, :object_type,
      pieces_attributes: [:id, :name, :description,
                          :model, :missing, :matrix, :restored_object_id, :_destroy],
      material_ids: [], category_ids: [], deterioration_ids: [])
  end
end