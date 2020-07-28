class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :comment_title, length: { in: 3..255 }
  validates_presence_of :comment_title, :comment_body
end
