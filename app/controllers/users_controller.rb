class UsersController < ApplicationController
  attr_reader :user

  before_action :find_user

  def show
    @user_support = Supports::UserSupport.new current_user
  end

  private

  def find_user
    @user = User.find_by id: params[:id]

    return if user
    flash[:danger] = t ".find_failed"
    redirect_to "/pages/home"
  end
end
