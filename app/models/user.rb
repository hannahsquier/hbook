class User < ApplicationRecord
  before_create :generate_auth_token
  after_create -> {create_profile( email: email, birthday: birthday ) }

  has_secure_password

  validates :password, length: { minimum: 6, maximum: 20 }, on: :create
  validates :first_name, presence: true, on: :create
  validates :last_name, presence: true, on: :create
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }

  has_many :posts
  has_many :comments
  has_one :profile
  has_many :likes, foreign_key: "liker_id"

  def full_name
    "#{first_name} #{last_name}"
  end

  def generate_auth_token
    begin
      self.auth_token = SecureRandom.urlsafe_base64
    end while User.exists?(auth_token: self.auth_token)
  end

  def regenerate_auth_token
    self.auth_token = nil
    generate_auth_token
    save
  end
end
