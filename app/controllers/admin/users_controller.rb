class Admin::UsersController < ApplicationController

  before_filter :authorized?

  def index
    @users = User.all.page(params[:page]).per(5)
  end

private

  def authorized?
    unless current_user && current_user.admin == true
      flash[:error] = "You are not authorized to view that page."
      redirect_to root_path
    end
  end
end
 