class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.references :user, foreign_key: true, index: true
      t.references :likable, polymorphic: true

      t.timestamps
    end
    add_index :likes, [:user_id, :likable_id, :likable_type], unique: true
  end
end
