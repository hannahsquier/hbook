class Profile < ApplicationRecord
  belongs_to :user, inverse_of: :profile

  # has_one :profile_photo, class_name: "Photo", foreign_key: :profile_photo_id

  # has_one :cover_photo, class_name: "Photo", foreign_key: :cover_photo_id


  belongs_to :profile_photo, class_name: "Photo", foreign_key: :profile_photo_id, optional: true

  belongs_to :cover_photo, class_name: "Photo", foreign_key: :cover_photo_id, optional: true

  def hometown
    hometown = ""

    [city, state, country].each do | place |
      hometown << place << ", " if place
    end

    hometown[0...-2]

  end
end
