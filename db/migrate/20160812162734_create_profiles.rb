class CreateProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :profiles do |t|
      t.date :birthday
      t.string :college
      t.string :city
      t.string :country
      t.string :state
      t.string :email
      t.string :phone
      t.text :words_to_live_by
      t.text :about_me
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
