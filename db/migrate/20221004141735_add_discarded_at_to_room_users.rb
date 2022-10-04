class AddDiscardedAtToRoomUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :room_users, :discarded_at, :datetime
    add_index :room_users, :discarded_at
  end
end
