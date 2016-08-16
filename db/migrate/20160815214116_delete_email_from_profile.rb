class DeleteEmailFromProfile < ActiveRecord::Migration[5.0]
  def change
    remove_column :profiles, :email
  end
end
