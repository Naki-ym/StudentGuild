class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :email, null: false, unique: true
      t.string :password_digest, null: false
      t.string :icon, null: false, default: "icon.png"
      t.boolean :delete_flg, null: false, default: false

      t.timestamps
    end
  end
end
