class Track < ApplicationRecord
  ATTRIBUTES = [:title, :description, :genre_id, :song, :user_id].freeze

  belongs_to :genre
  belongs_to :uploader, class_name: User.name, foreign_key: "user_id"

  has_many :comments, as: :comment_object
  has_many :commenters, through: :comments, source: :user
  has_many :likes, as: :like_object
  has_many :interested, through: :likes, source: :user
  has_many :albums, through: :album_tracks

  mount_uploader :song, SongUploader

  validates :title, presence: true,
    length: {maximum: Settings.validates.track.title.maximum}
  validates :song, presence: true
  validates :user_id, presence: true, allow_nil: true
  validates :genre, presence: true
  validates :image, presence: true, allow_nil: true

  scope :get_random, ->{order "RANDOM()"}
  scope :take_three, ->{take 3}

  delegate :name, to: :uploader, prefix: :uploader, allow_nil: true
  delegate :name, to: :genre, prefix: :genre, allow_nil: true

  def update_view
    self.view = view + 1
    save
  end
end
