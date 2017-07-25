class CreateGenres < ActiveRecord::Migration[5.0]
  def change
    drop_table :genres, if_exists: true
    create_table :genres do |t|
      t.string :name

      t.timestamps
    end
    add_index :genres, :name, unique: true
  end
end
