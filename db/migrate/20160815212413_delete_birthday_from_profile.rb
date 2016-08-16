class DeleteBirthdayFromProfile < ActiveRecord::Migration[5.0]
  def change
    remove_column :profiles, :birthday
  end
end
