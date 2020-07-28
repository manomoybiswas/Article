class Post < ApplicationRecord
  belongs_to :category
  belongs_to :user
  has_many :comments
  has_many :likes
  
  validates :post_name, length: { in: 10..150 }
  validates_presence_of :post_name, :description
end
