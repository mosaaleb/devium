class AddLikesCounterCacheToComments < ActiveRecord::Migration[5.2]
  def change
    add_column :comments, :likes_count, :integer, default: 0, null: false
  end
end
