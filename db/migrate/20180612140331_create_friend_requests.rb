class CreateFriendRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :friend_requests do |t|
      t.integer :befriender_id, index: true
      t.integer :befriendee_id, index: true

      t.timestamps
    end
    add_foreign_key :friend_requests, :users, column: :befriender_id
    add_foreign_key :friend_requests, :users, column: :befriendee_id
  end
end
