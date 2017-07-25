class CreateLikes < ActiveRecord::Migration[5.0]
  def change
    drop_table :likes, if_exists: true
    create_table :likes do |t|
      t.references :user
      t.integer :like_object_id
      t.string :like_object_type

      t.timestamps
    end
    add_index :likes, :like_object_id
    add_index :likes, :like_object_type
    add_index :likes, [:like_object_id, :like_object_type], unique: true
  end
end
