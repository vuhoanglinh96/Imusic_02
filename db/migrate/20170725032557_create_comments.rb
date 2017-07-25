class CreateComments < ActiveRecord::Migration[5.0]
  def change
    drop_table :comments, if_exists: true
    create_table :comments do |t|
      t.references :user
      t.integer :comment_object_id
      t.string :comment_object_type
      t.string :content

      t.timestamps
    end
    add_index :comments, :comment_object_id
    add_index :comments, :comment_object_type
    add_index :comments, [:comment_object_type, :comment_object_id]
  end
end
