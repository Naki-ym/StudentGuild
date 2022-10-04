class CreateRooms < ActiveRecord::Migration[6.1]
  def change
    create_table :rooms do |t|
      t.text :name, null: false
      t.text :caption, null: false
      t.boolean :is_group_chat, null: false, default: false

      t.timestamps
    end
  end
end
