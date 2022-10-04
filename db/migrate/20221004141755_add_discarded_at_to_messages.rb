class AddDiscardedAtToMessages < ActiveRecord::Migration[6.1]
  def change
    add_column :messages, :discarded_at, :datetime
    add_index :messages, :discarded_at
  end
end
