class CategoriesController < ApplicationController

  def index
    @categories  = Category.all
    @objects     = RestoredObject.all
    half_size    = @categories.count/2+1
    @first_half  = @categories[0..half_size] 
    @second_half = @categories[half_size..(@categories.count)]
    @first_sixs_elements       = @objects[0..5]
    @second_three_elements     = @objects[5..7]
    @random_outstanding_object = getRandomObject
  end

  def show    
    @categories  = Category.all
    @objects     = RestoredObject.all
    @category    = Category.find(params[:id])
    @category_id = params[:id]    
  end

  def getRandomObject
    random_object = nil
    while(random_object == nil)
      id = rand(0..(RestoredObject.all.count))
      if (RestoredObject.exists?(id))
        random_object = RestoredObject.find(id)
      else
        random_object = nil
      end
    end
    return random_object
  end

end
