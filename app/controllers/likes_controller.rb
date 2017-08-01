class LikesController < ApplicationController
  attr_reader :track
  def create
    @track = Track.find_by id: params[:like][:track_id]
    current_user.like_track track
    @unlike = current_user.likes.find_by like_object_id: track.id
    respond
  end

  def destroy
    @track = Like.find_by(id: params[:id]).like_object
    current_user.unlike_track track
    @like = current_user.likes.build
    respond
  end

  private

  def respond
    respond_to do |format|
      format.html{redirect_to track}
      format.js
    end
  end
end
