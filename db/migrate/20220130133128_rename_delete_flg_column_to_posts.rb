class RenameDeleteFlgColumnToPosts < ActiveRecord::Migration[6.1]
  def change
    rename_column :posts, :delete_flg, :is_deleted
  end
end
