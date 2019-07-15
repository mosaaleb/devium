class CreateProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :profiles do |t|
      t.references :user, index: {:unique=>true}, foreign_key: true
      t.string :first_name
      t.string :last_name
      t.string :gender
      t.date :date_of_birth
      t.text :about_me

      t.timestamps
    end
  end
end
