class CreateTracks < ActiveRecord::Migration[5.0]
  def change
    drop_table :tracks, if_exists: true
    create_table :tracks do |t|
      t.string :title
      t.references :genre
      t.references :user
      t.string :song
      t.string :description
      t.string :image
      t.integer :view, default: 0

      t.timestamps
    end
    add_index :tracks, :title
  end
end
