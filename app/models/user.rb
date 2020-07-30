class User < ApplicationRecord
  acts_as_voter
  has_secure_password
  
  has_many :post
  has_many :likes
  has_many :comments

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  VALID_PHONE_REGEX=/\A[6-9][0-9]{9}\z/.freeze

  validates :name, :email, length: { in: 3..30 }
  validates :mobile, length: { is: 10}, format: {with: VALID_PHONE_REGEX}
  validates :email, length: { in: 8..30 },format: {with: VALID_EMAIL_REGEX}
  validates :password, length: { minimum: 5 }
  validates_presence_of :name, :email, :mobile, :password
  validates_uniqueness_of :email, :mobile, case_sensitive: false
end
