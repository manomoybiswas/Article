class Category < ApplicationRecord
  has_many :post, dependent: :destroy

  validates :category_name, length: {in: 3..30 }
  validates_presence_of :category_name
end
