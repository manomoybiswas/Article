class User < ApplicationRecord
  acts_as_voter
  has_secure_password
  
  has_many :post
  has_many :likes
  has_many :comments

  mount_uploader :avater, AvaterUploader

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  VALID_PHONE_REGEX=/\A[6-9][0-9]{9}\z/.freeze

  validates :name, :email, length: { in: 3..30 }
  validates :mobile, length: { is: 10}, format: {with: VALID_PHONE_REGEX}
  validates :email, length: { in: 8..30 },format: {with: VALID_EMAIL_REGEX}
  validates :password, length: { minimum: 5 }, on: :create
  validates_presence_of :name, :email, :mobile
  validates_presence_of :password, on: :create
  validates_uniqueness_of :email, :mobile, case_sensitive: false

  before_create { generate_token(:auth_token) }

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    ResetPasswordWorker.perform_async(self.id)
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end
end
