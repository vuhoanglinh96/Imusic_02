class Genre < ApplicationRecord
  has_many :tracks

  validates :name, presence: :true,
    length: {maximum: Settings.validates.track.title.maximum}
end
