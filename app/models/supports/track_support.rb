class Supports::TrackSupport
  attr_reader :user, :track

  def initialize user, track
    @user = user
    @track = track
  end

  def related
    id = track.id
    Genre.find_by(id: track.genre_id).tracks
         .where.not(id: id).get_random.take_three
  end

  def track_artist
    id = track.id
    User.find_by(id: track.user_id).tracks
        .where.not(id: id).get_random.take_three
  end

  def like
    user.likes.build
  end

  def unlike
    user.likes.find_by like_object_id: track.id
  end
end
