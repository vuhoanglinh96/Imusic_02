class Genre < ApplicationRecord
  has_many :tracks

  validates :name, presence: :true,
    length: {maximum: Settings.validates.track.title.maximum}

  def genres_collect
    Genre.all.map{|genre| [genre.name, genre.id]}
  end
end
