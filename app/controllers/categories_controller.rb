class CategoriesController < ApplicationController

  def index
    @categories = Category.all
    @objects = RestoredObject.all
  end

  def show    
    @categories  = Category.all
    @objects     = RestoredObject.all
    @category    = Category.find(params[:id])
    @category_id = params[:id]
  end

end
