class AddDiscardedAtToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :discarded_at, :datetime
    add_index :posts, :discarded_at
  end
end
