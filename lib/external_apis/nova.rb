require 'nokogiri'
require 'open-uri'

module ExternalApis
  class Nova
    attr_reader :timestamp

    def initialize(timestamp)
      @timestamp = timestamp
    end

    def self.fetch(timestamp = Time.current.to_i)
      instance = self.new(timestamp)
      instance.get_tracks
    end

    #Return 20 which are around the timestamp
    def get_tracks
      html_tracks.map do |html_track|
        track(html_track)
      end
    end

  private

    def html_tracks
      doc = Nokogiri::HTML(open("http://www.novaplanet.com/radionova/cetaitquoicetitre/#{timestamp}"))
      doc.xpath('//h2[@class="artiste"]')
    end

    def track(html_track)
      radio_name   = radio_name(html_track)
      radio_artist = radio_artist(html_track)
      Track.new(radio_artist: radio_artist,
                radio_name:   radio_name,
                formatted_name: formatted_name(radio_name),
                formatted_artist: formatted_artist(radio_artist),
                played_at:    played_at(html_track))
    end

    # Keep only 4 words (removing the featurings)
    def radio_name(html_track)
      html_track.parent.children[3].content.squish
    end

    def formatted_name(radio_name)
      radio_name.sub(/( (ft|feat|featuring).+)\z/i, '').
                              split(' ')[0..3].join(' ')
    end

    def formatted_artist(radio_artist)
      radio_artist.sub(/\/(.+)\z/, '')
    end

    # Keep only the part before '/'
    def radio_artist(html_track)
      html_track.content.squish
    end

    def played_at(html_track)
      Time.zone.at(html_track.parent.parent['class'][/timestamp_(\d+)/,1].to_i)
    end
  end
end