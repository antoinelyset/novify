class AddFormattedDataToTracks < ActiveRecord::Migration
  def change
    add_column :tracks, :formatted_name, :string
    add_column :tracks, :formatted_artist, :string
  end
end
