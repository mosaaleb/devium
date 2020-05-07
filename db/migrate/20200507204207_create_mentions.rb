# frozen_string_literal: true

class CreateMentions < ActiveRecord::Migration[5.2]
  def change
    create_table :mentions do |t|
      t.references :mentioned, foreign_key: { to_table: :users }, index: true
      t.references :mentioner, foreign_key: { to_table: :users }
      t.references :mentionable, polymorphic: true

      t.timestamps
    end

    add_index :mentions,
              %i[mentioned_id mentioner_id mentionable_type mentionable_id],
              unique: true,
              name: 'mention_idx_mentionable_mentioner_mentioned'
  end
end
