class CreateAlbumTracks < ActiveRecord::Migration[5.0]
  def change
    drop_table :album_tracks, if_exists: true
    create_table :album_tracks do |t|
      t.references :album
      t.references :track

      t.timestamps
    end
  end
end
