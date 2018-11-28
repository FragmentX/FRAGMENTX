class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def isObjectFromUser(obj)
    return current_user == obj.user
  end

  helper_method :isObjectFromUser

end