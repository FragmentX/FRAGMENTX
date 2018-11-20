class HomeController < ApplicationController
  def index
    @featured = RestoredObject.first(3)
  end
end
