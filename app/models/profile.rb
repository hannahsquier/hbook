class Profile < ApplicationRecord
  belongs_to :user


  def hometown
    hometown = ""

    [city, state, country].each do | place |
      hometown << place << ", " if place
    end

    hometown[0...-2]

  end
end
