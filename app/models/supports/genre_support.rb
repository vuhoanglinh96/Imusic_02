class Supports::GenreSupport
  attr_reader :genre

  def initialize genre
    @genre = genre
  end

  def track
    Track.new
  end

  def tracks_genre
    genre.tracks
  end

  def genres
    Genre.all
  end

  def genres_map
    Genre.new
  end
end
