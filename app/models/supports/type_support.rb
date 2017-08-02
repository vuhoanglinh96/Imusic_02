class Supports::TypeSupport
  def initialize; end

  def track
    @track = Track.new
  end

  def genres_map
    Genre.new
  end

  def genres
    Genre.all
  end
end
