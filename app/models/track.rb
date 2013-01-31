class Track < ActiveRecord::Base
  has_and_belongs_to_many :playlists

  attr_accessible :href, :playlists
  attr_accessible :radio_name,   :radio_artist
  attr_accessible :spotify_name, :spotify_artist

  validates_presence_of   :radio_name, :radio_artist, :playlists
  validates_uniqueness_of :href
  validates_uniqueness_of :radio_name, :scope => :radio_artist
end
