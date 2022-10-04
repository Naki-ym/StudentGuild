class AddDiscardedAtToRooms < ActiveRecord::Migration[6.1]
  def change
    add_column :rooms, :discarded_at, :datetime
    add_index :rooms, :discarded_at
  end
end
