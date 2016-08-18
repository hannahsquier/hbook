class AddFileColsToPhotos < ActiveRecord::Migration[5.0]
  def change
  	add_attachment :photos, :file
  end
end
