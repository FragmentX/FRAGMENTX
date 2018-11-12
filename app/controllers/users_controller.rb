class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def getRandomPosition(index)
    return ((rand(0..10)) > 4)
  end

  helper_method :getRandomPosition

end