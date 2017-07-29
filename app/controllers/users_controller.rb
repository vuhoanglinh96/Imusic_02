class UsersController < ApplicationController
  # before_action :redirect
  before_action :find_user

  def show
    @track = current_user.tracks.build if current_user
    @genres = Genre.all
    @track_index = User.find_by(id: params[:id]).tracks
  end

  private

  def find_user
    @user = User.find_by id: params[:id]
    unless @user
      flash[:danger] = "Can't find user"
      redirect_to "/pages/home"
    end
  end

  def redirect
    redirect_to root_path unless current_user
  end
end
