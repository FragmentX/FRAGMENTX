class CategoriesController < ApplicationController

  def index
    @categories  = Category.all
    @objects     = RestoredObject.all
    half_size    = @categories.count/2+1
    @first_half  = @categories[0..half_size] 
    @second_half = @categories[half_size..(@categories.count-1)]
    if @objects.count >= 6
      @first_sixs_elements      = @objects[0..5]
      if @objects.count >= 12
        @second_three_elements  = @objects[5..7]
      else
        @second_three_elements  = @objects[5..(@categories.count-1)]
      end
    else
      @first_sixs_elements      = @objects[0..(@categories.count-1)]
      @second_three_elements    = nil
    end    
    
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
