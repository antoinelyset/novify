class ChangeStringTypeToText < ActiveRecord::Migration
  def change
    change_column :tracks, :radio_name,       :text
    change_column :tracks, :radio_artist,     :text
    change_column :tracks, :spotify_name,     :text
    change_column :tracks, :spotify_artist,   :text
    change_column :tracks, :formatted_name,   :text
    change_column :tracks, :formatted_artist, :text
  end
end
