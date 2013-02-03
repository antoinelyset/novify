class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.references :radio
      t.time   :played_at
      t.string :href
      t.string :radio_name
      t.string :radio_artist
      t.string :spotify_name
      t.string :spotify_artist

      t.timestamps
    end
  end
end
