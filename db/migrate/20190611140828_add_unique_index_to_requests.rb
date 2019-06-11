class AddUniqueIndexToRequests < ActiveRecord::Migration[5.2]
  def change
    add_index :requests, [:sender_id, :receiver_id], unique: true
  end
end
