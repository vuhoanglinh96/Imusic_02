class CreateGroupUsers < ActiveRecord::Migration[5.0]
  def change
    drop_table :group_users, if_exists: true
    create_table :group_users do |t|
      t.references :group
      t.references :user

      t.timestamps
    end
  end
end
