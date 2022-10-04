class AddDiscardedAtToTagCategories < ActiveRecord::Migration[6.1]
  def change
    add_column :tag_categories, :discarded_at, :datetime
    add_index :tag_categories, :discarded_at
  end
end
