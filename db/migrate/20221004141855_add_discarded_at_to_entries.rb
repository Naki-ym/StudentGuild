class AddDiscardedAtToEntries < ActiveRecord::Migration[6.1]
  def change
    add_column :entries, :discarded_at, :datetime
    add_index :entries, :discarded_at
  end
end
