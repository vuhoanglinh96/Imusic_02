class Track < ApplicationRecord
  ATTRIBUTES = %i(title description genre_id song user_id view).freeze

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
  scope :take_three, ->{take Settings.take_three}
  scope :desc, ->{order created_at: :desc}
  scope :top_listen, ->{order view: :desc}

  delegate :name, to: :uploader, prefix: :uploader, allow_nil: true
  delegate :name, to: :genre, prefix: :genre, allow_nil: true
end
