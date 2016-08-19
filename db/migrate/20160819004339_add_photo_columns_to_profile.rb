class AddPhotoColumnsToProfile < ActiveRecord::Migration[5.0]
  def change
  	add_column :profiles, :profile_picture_id, :integer, null: true
  	add_column :profiles, :cover_photo_id, :integer, null: true
  end
end
