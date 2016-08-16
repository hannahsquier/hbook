class CreateFriendings < ActiveRecord::Migration[5.0]
  def change
    create_table :friendings do |t|
      t.integer :friender_id, null:false
      t.integer :friended_id, null: false
      t.timestamps
    end
    add_index :friendings, [:friender_id, :friended_id], unique: false
  end
end
