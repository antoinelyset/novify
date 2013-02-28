class Track < ActiveRecord::Base
  after_save :update_radio_started_at, :update_radio_ended_at

  belongs_to :radio

  attr_accessible :href, :played_at
  attr_accessible :radio_name,     :radio_artist
  attr_accessible :formatted_name, :formatted_artist
  attr_accessible :spotify_name,   :spotify_artist

  validates_presence_of  :played_at, :radio_name, :radio_artist, :radio

private
  def update_radio_started_at
    if radio.started_at.nil? || played_at < radio.started_at
      radio.started_at = played_at
      radio.save!
    end
  end

  def update_radio_ended_at
    if radio.ended_at.nil?   || played_at > radio.ended_at
      radio.ended_at = played_at
      radio.save!
    end
  end
end
