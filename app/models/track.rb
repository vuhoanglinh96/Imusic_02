class Track < ApplicationRecord
  belongs_to :genre
  belongs_to :uploader, class_name: User.name, foreign_key: "user_id"

  has_many :comments, as: :comment_object
  has_many :commenters, through: :comments, source: :user
  has_many :likes, as: :like_object
  has_many :interested, through: :likes, source: :user
  has_many :albums, through: :album_tracks
end
