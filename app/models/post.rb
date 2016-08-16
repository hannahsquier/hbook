class Post < ApplicationRecord
  belongs_to :receiver, class_name: 'User', foreign_key: 'receiver_id'

  belongs_to :author, class_name: 'User', foreign_key: 'user_id'
  has_many :comments, as: :commentable, dependent: :destroy

  has_many :likes, as: :likeable
  validates :body, presence: true
end
