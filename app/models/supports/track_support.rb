class Supports::TrackSupport
  attr_reader :user, :track

  def initialize user, track
    @user = user
    @track = track
  end

  def related
    id = track.id
    track.genre.tracks.where.not(id: id).get_random.take_three
  end

  def track_artist
    id = track.id
    track.uploader.tracks.where.not(id: id).get_random.take_three
  end
end
