class CategoriesController < ApplicationController

  def index
    @categories  = Category.all
    @objects     = RestoredObject.all
    half_size    = @categories.count/2+1
    @first_half  = @categories[0..half_size] 
    @second_half = @categories[half_size..(@categories.count)]
  end

  def show    
    @categories  = Category.all
    @objects     = RestoredObject.all
    @category    = Category.find(params[:id])
    @category_id = params[:id]    
  end

end
