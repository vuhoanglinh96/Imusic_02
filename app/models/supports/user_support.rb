class Supports::UserSupport
  attr_reader :user

  def initialize user
    @user = user
  end

  def genres_map
    Genre.new
  end

  def track
    user.tracks.build if user
  end

  def genres
    Genre.all
  end
end
