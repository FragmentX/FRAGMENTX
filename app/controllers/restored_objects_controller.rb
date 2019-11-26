require 'zip'

class RestoredObjectsController < ApplicationController
  before_action :set_restored_object, only: %i[show edit update destroy]

  layout :resolve_layout


  # GET /restored_objects
  # GET /restored_objects.json
  def index
    @objects = RestoredObject.all.where(current_step: 'active').page params[:page]
    authorize @objects
  end

  # GET /restored_objects/1
  # GET /restored_objects/1.json
  def show
    authorize @object
    gon.pieces = []
    gon.matrices = []
    gon.materials = []
    gon.images = []
    gon.missings = []
    @object.pieces.each do |p|
      gon.pieces << p.model.service_url&.split("?")&.first if p.model.attached?
      gon.materials << p.material.service_url&.split("?")&.first if p.material.attached?
      gon.matrices << p.matrix
      gon.missings << p.missing
    end
  end

  # GET /restored_objects/new
  def new
    @object = RestoredObject.new
    authorize @object
    @object.user_id = current_user.id
    @object.save
    redirect_to restored_object_build_path(:basic_info, restored_object_id: @object.id)
  end

  # GET /restored_objects/1/edit
  def edit
    authorize @object
  end

  # POST /restored_objects
  # POST /restored_objects.json
  def create
    @object = RestoredObject.new(restored_object_params)
    @object.user_id = current_user.id
    authorize @object
    if params[:zip_file]
      params[:pieces_attributes] = nil
      puts "About to read the file"
      Zip::File.open(params[:zip_file].path) do |zipfile|
        puts "Reading zip file"
        zipfile.glob('*{ply,stl,obj}') do |file|
            puts "Reading #{file.name}"
            # tempfile = Tempfile.new(File.basename(file.name))
            # tempfile.binmode
            # tempfile.write file.get_input_stream.read

            if @object.object_type == nil
              case file.name.split('.').last.downcase
              when 'ply' then @object.object_type = 'ply'
              when 'stl' then @object.object_type = 'stl'
              when 'obj' then @object.object_type = 'obj'
              end
            end

            puts "Reading matrix"
            matrix = zipfile.glob("#{file.name.split('.').first}.txt").first.get_input_stream.read
            puts matrix

            piece = @object.pieces.create(name: file.name, matrix: matrix)
          end
      end
    end

    respond_to do |format|
      if @object.save
        format.html { redirect_to @object }
        format.json do
          render :show,
                 status: :created, location: @object
        end
      else
        format.html { render :new }
        format.json do
          render json: @object.errors,
                 status: :unprocessable_entity
        end
      end
    end
  end

  # PATCH/PUT /restored_objects/1
  # PATCH/PUT /restored_objects/1.json
  def update
    authorize @object
    respond_to do |format|
      if @object.update(restored_object_params)
        format.html { redirect_to restored_object_path(@object) }
        format.json { render :show, status: :ok, location: @object }
      else
        format.html { render :edit }
        format.json do
          render json: @object.errors,
                 status: :unprocessable_entity
        end
      end
    end
  end

  # DELETE /restored_objects/1
  # DELETE /restored_objects/1.json
  def destroy
    authorize @object
    @object.destroy
    redirect_to(restored_objects_path)
  end

  private

  def resolve_layout
    case action_name
    when "show"
      "threejs"
    else
      "application"
    end
  end

  def set_restored_object
    @object = RestoredObject.find(params[:id])
  rescue StandardError
    redirect_to(restored_objects_path)
  end

  def restored_object_params
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
