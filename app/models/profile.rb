class Profile < ApplicationRecord
  belongs_to :user, inverse_of: :profile


  def hometown
    hometown = ""

    [city, state, country].each do | place |
      hometown << place << ", " if place
    end

    hometown[0...-2]

  end
end
