class CollectionsController < ApplicationController

  def index
    @collections  = Collection.all
    authorize @collections
  end

  def show
    @collection  = Collection.find(params[:id])
    authorize @collection
    @objects   = @collection.restored_objects.page params[:page]
  end

  def new
    @collection = Collection.new
    authorize @collection
  end

  def create
    @collection = Collection.new(collection_params)
    @collection.user_id = current_user.id
    authorize @collection
    respond_to do |format|
      if @collection.save
        format.html { redirect_to @collection }
        format.json do
          render :show,
                 status: :created, location: @collection
        end
      else
        format.html { render :new }
        format.json do
          render json: @collection.errors,
                 status: :unprocessable_entity
        end
      end
    end
  end

  def edit
    @collection  = Collection.find(params[:id])
    authorize @collection
  end

  def update
    @collection = Collection.find(params[:id])
    authorize @collection
    respond_to do |format|
      if @collection.update(collection_params)
        format.html { redirect_to @collection }
        format.json do
          render :show,
                 status: :created, location: @collection
        end
      else
        format.html { render :new }
        format.json do
          render json: @collection.errors,
                 status: :unprocessable_entity
        end
      end
    end
  end

  def destroy
    @collection = Collection.find(params[:id])
    authorize @collection
    @collection.destroy
    redirect_to(collections_path)
  end

  private

  def collection_params
    params.require(:collection).permit(:title, :description,
      collections_restored_objects_attributes: [:id, :collection_id, :restored_object_id, :_destroy])
  end

end
