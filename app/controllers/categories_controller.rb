class CategoriesController < ApplicationController


  def index
    @categories = Category.all
    @objects = RestoredObject.all
  end

  def show    
    
  end

end
