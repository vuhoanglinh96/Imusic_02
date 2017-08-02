class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    drop_table :users, if_exists: true
    create_table :users do |t|
      t.string :name
      t.boolean :admin, default: false
      t.string :avatar

      t.timestamps
    end
    add_index :users, :name
  end
end
