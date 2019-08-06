class HomeController < ApplicationController
  def index
    @featured = RestoredObject.first(3)
    @featured_museum = User.last
  end
end
