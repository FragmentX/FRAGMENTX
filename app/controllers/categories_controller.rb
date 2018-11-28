class CategoriesController < ApplicationController

  def index

  end

  def show
    @category    = Category.find(params[:id])
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
