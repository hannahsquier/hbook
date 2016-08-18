class Like < ApplicationRecord
  belongs_to :likeable, polymorphic: true
  belongs_to :liker, class_name: "User", foreign_key: :liker_id

  validates_uniqueness_of :id, :scope => [:liker_id, :likeable_id, :likeable_type]

end
