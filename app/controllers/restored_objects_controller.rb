class RestoredObjectsController < ApplicationController
  before_action :set_restored_object, only: %i[show edit update destroy]

  layout :resolve_layout


  # GET /restored_objects
  # GET /restored_objects.json
  def index
    @objects = RestoredObject.all
  end

  # GET /restored_objects/1
  # GET /restored_objects/1.json
  def show
    #authorize @object
    @pieces = @object.pieces
  end

  # GET /restored_objects/new
  def new
    @object = RestoredObject.new
    #authorize @object
  end

  # GET /restored_objects/1/edit
  def edit
    #authorize @object
  end

  # POST /restored_objects
  # POST /restored_objects.json
  def create
    @object = RestoredObject.new(restored_object_params)
    @object.user_id = current_user.id
    #authorize @object
    respond_to do |format|
      if @object.save
        format.html { redirect_to @object }
        format.json do
          render :show,
                 status: :created, location: @object
        end
      else
        puts @object.errors.first
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
    #authorize @object
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
    #authorize @object
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
    params.require(:restored_object).permit(:title, :description,
      pieces_attributes: [:id, :name, :description, :model, :missing, :matrix, :restored_object_id, :_destroy])
  end
end
