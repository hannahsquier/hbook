class AddReferencesToProfilePhotoColumns < ActiveRecord::Migration[5.0]
  def change
  	change_column :profiles, :profile_photo_id, :integer, references: "photo"
  	change_column :profiles, :cover_photo_id, :integer, references: "photo"
  end
end
