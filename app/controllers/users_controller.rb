class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def isObjectFromUser(obj)
    return current_user == obj.user
  end

  helper_method :isObjectFromUser

  def create
    @user = User.create(user_params)
  end

  private

  # Use strong_parameters for attribute whitelisting
  # Be sure to update your create() and update() controller methods.

  def user_params
    params.require(:user).permit(:avatar)
  end

end