class ChangeAuthorIdToUserId < ActiveRecord::Migration[5.0]
  def change
    remove_column :comments, :author_id
    add_column :comments, :user_id, :references
      add_index :comments, :user_id

  end

end
