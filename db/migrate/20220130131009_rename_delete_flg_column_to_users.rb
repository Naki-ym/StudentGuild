class RenameDeleteFlgColumnToUsers < ActiveRecord::Migration[6.1]
  def change
    rename_column :users, :delete_flg, :is_deleted
  end
end
