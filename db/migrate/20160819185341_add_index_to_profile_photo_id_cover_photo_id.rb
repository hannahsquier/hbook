class AddIndexToProfilePhotoIdCoverPhotoId < ActiveRecord::Migration[5.0]
  def change
  	add_index :profiles, :profile_photo_id
  	add_index :profiles, :cover_photo_id
  end
end
