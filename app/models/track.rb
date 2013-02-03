class Track < ActiveRecord::Base
  belongs_to :radio

  attr_accessible :href, :played_at
  attr_accessible :radio_name,     :radio_artist
  attr_accessible :formatted_name, :formatted_artist
  attr_accessible :spotify_name,   :spotify_artist

  validates_presence_of  :played_at, :radio_name, :radio_artist, :radio

  # Keep only the part before '/' for the artist
  # Keep only 4 words for the title
  def reformat_radio_data
    self.formatted_artist = self.radio_artist.sub(/\/(.+)\z/, '')
    self.formatted_name   = self.radio_name.
                                  sub(/( (ft|feat|featuring).+)\z/i, '').
                                  split(' ')[0..3].join(' ')
    self
  end
end
