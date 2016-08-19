class AddProfilePhotoAndCoverPhotoFkToProfile < ActiveRecord::Migration[5.0]
  def change
  	add_column :profiles, :profile_photo_id, :integer
  	add_column :profiles, :cover_photo_id, :integer

  end
end
