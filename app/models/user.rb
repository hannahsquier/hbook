class User < ApplicationRecord
  before_create :generate_auth_token
  after_create -> { create_profile }

  has_secure_password

  validates :password, length: { minimum: 6, maximum: 20 }, on: :create
  validates :first_name, presence: true, on: :create
  validates :last_name, presence: true, on: :create
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }, uniqueness: true
  validates :gender, allow_nil:true, inclusion: { in: %w(male female other) }

  validates_each :birthday do |user, birthday, value|
    if value && value >= Time.now.to_date
      user.errors.add(birthday, 'must be in the past')
    end
  end

  validates_each :birthday do |user, birthday, value|
    if value && value <= (Time.now.to_date - 125.years)
      user.errors.add(birthday, 'must be less than 125 years in the past')
    end
  end

  has_many :posts
  has_many :comments
  has_one :profile, inverse_of: :user
  has_many :likes, foreign_key: "liker_id"

  # When acting as the initiator of the friending
  has_many :initiated_friendings, foreign_key: :friender_id, class_name: "Friending"
  has_many :friended_users, through: :initiated_friendings, source: :friend_recipient

  # When acting as person friended
  has_many :received_friendings, foreign_key: :friended_id, class_name: "Friending"
  has_many :users_friended_by, through: :received_friendings, source: :friend_initiator

  accepts_nested_attributes_for :profile

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


  private
  def is_valid_birthday?
    if((birthday.is_a?(Date) rescue ArgumentError) == ArgumentError)
      errors.add(:birthday, 'Sorry, Invalid Date of Birth Entered.')
    end
  end
end
