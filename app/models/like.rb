class Like < ApplicationRecord
  belongs_to :user
  belongs_to :like_object, polymorphic: true
end
