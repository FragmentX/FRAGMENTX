class UsersController < ApplicationController

  def show
    if params[:id]
      @user = User.find(params[:id])
    elsif params[:username]
      @user = User.where(username: params[:username]).first
    end
  end

  def admin
    if !current_user || !current_user.admin
      flash[:danger] = t('shared.not_authorized')
      redirect_to root_path
    end
    @candidates = User.where(approved: false)
  end

  def isObjectFromUser(obj)
    return current_user == obj.user
  end

  helper_method :isObjectFromUser

  def create
    @user = User.create(user_params)
  end

  def approve
    @user = User.find(params[:id])
    
    if !current_user || !current_user.admin
      flash[:danger] = t('shared.not_authorized')
      redirect_to root_path
    end

    @user.update(approved: :true)
    flash[:notice] = t('users.approved', user: @user.username)
    redirect_to :admin_panel
  end

  def deny
    @user = User.find(params[:id])
    
    if !current_user || !current_user.admin || @user.approved 
      flash[:danger] = t('shared.not_authorized')
      redirect_to root_path
    end

    @user.destroy!
    flash[:notice] = t('users.denied', user: @user.username)
    redirect_to :admin_panel
  end

  private

  # Use strong_parameters for attribute whitelisting
  # Be sure to update your create() and update() controller methods.

  def user_params
    params.require(:user).permit(:avatar, :approved)
  end

end