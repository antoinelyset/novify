class Track < ActiveRecord::Base
  belongs_to :radio

  attr_accessible :href, :played_at
  attr_accessible :radio_name,     :radio_artist
  attr_accessible :formatted_name, :formatted_artist
  attr_accessible :spotify_name,   :spotify_artist

  validates_presence_of  :played_at, :radio_name, :radio_artist, :radio
end
