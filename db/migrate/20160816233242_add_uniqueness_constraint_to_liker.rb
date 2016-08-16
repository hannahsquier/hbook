class AddUniquenessConstraintToLiker < ActiveRecord::Migration[5.0]
  def change
    add_index :likes, :liker_id, unique: true


  end
end
