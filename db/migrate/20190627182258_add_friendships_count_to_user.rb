class AddFriendshipsCountToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :friendships_count, :integer, default: 0, null: false
  end
end
