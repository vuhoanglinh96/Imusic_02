class User < ApplicationRecord
  has_many :tracks, dependent: :destroy
  has_many :albums, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :albums_interested, through: :likes, source: :like_object,
    source_type: Album.name
  has_many :track_interested, through: :likes, source: :like_object,
    source_type: Track.name
  has_many :comments, dependent: :destroy
  has_many :albums_commenters, through: :comments, source: :comment_object,
    source_type: Album.name
  has_many :tracks_commenters, through: :comments, source: :comment_object,
    source_type: Track.name
  has_many :group_users, dependent: :destroy
  has_many :groups, through: :group_users
  has_many :active_relationships, class_name: Relationship.name,
    foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: Relationship.name,
    foreign_key: "followed_id", dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
end
