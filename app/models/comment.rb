class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :object_comment, polymorphic: true
end
