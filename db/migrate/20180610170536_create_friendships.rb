class CreateFriendships < ActiveRecord::Migration[5.1]
  def change
    create_table :friendships do |t|
      t.integer :friend_id, index: true
      t.integer :inverse_friend_id, index: true

      t.timestamps
    end
    add_foreign_key :friendships, :users, column: :friend_id
    add_foreign_key :friendships, :users, column: :inverse_friend_id
  end
end
