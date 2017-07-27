class Genre < ApplicationRecord
  has_many :tracks

  validates :name, presence: :true, length: {maximum: 50}
end
