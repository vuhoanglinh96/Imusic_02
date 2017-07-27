class CreateAlbums < ActiveRecord::Migration[5.0]
  def change
    drop_table :albums, if_exists: true
    create_table :albums do |t|
      t.references :user
      t.string :title

      t.timestamps
    end
    add_index :albums, :title
  end
end
