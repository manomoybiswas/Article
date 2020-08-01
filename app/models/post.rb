class Post < ApplicationRecord
  acts_as_votable
  
  belongs_to :category
  belongs_to :user
  has_many :comments
  has_many :likes
  
  mount_uploader :image, PosterUploader

  validates :post_name, length: { in: 10..150 }
  validates_presence_of :post_name, :description

  scope :filtered_by_category, -> (id) { where(category_id: id)}
  scope :find_post, -> (user) { where(user_id: user.id).includes(:category, :comments)}
  scope :search, -> (query) { where("lower(post_name) LIKE ?", "%#{query.downcase}%")}

  def self.filter(id)
    if id == "0" || id == "" || id == nil
      self.includes(:category, :user).all
    else
      self.filtered_by_category(id)
    end
  end

  def self.filtered_by_like(id, param, current_user)
    if param == "" || param == nil || !current_user
      self.filter(id)
    elsif param == "Liked" && param
        self.joins(:likes).where(likes: {user_id: current_user.id})
    end
  end
end
