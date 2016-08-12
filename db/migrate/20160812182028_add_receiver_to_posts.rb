class AddReceiverToPosts < ActiveRecord::Migration[5.0]
  def change
#rename_column :posts, :user_id, :author_id
    add_column :posts, :receiver_id, :integer, foreign_key: true
    add_index :posts, :receiver_id

  end
end
