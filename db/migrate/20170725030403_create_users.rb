class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    drop_table :users, if_exists: true
    create_table :users do |t|
      t.string :name
      t.string :email, unique: true
      t.string :password_digest
      t.string :activate_digest
      t.boolean :activated, default: false
      t.boolean :admin, default: false
      t.string :avatar

      t.timestamps
    end
    add_index :users, :email, unique: true
    add_index :users, :user
  end
end
