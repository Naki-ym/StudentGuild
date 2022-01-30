class RenameDeleteFlgColumnToFavorites < ActiveRecord::Migration[6.1]
  def change
    rename_column :favorites, :delete_flg, :is_deleted
  end
end
