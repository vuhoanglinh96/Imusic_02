class UsersController < ApplicationController
  before_action :find_user

  def show
    @track = current_user.tracks.build if current_user
    @genres = Genre.all
    @track_index = User.find_by(id: params[:id]).tracks
    @genres_map = Genre.new
  end

  private

  def find_user
    user = User.find_by id: params[:id]
    return @user = user if user
    flash[:danger] = t ".find_failed"
    redirect_to "/pages/home"
  end
end
