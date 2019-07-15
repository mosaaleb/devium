class AddReceivedAndSentRequestsCountToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :received_requests_count, :integer, default: 0, null: false
    add_column :users, :sent_requests_count, :integer, default: 0, null: false
  end
end
