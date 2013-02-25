require 'nokogiri'
require 'open-uri'

module ExternalApis
  class Nova
    attr_reader :timestamp

    def initialize(timestamp)
      @timestamp = timestamp
    end

    def self.fetch(timestamp = Time.now.to_i)
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
      Track.new(radio_artist: radio_artist(html_track),
                radio_name:   radio_name(html_track),
                played_at:    played_at(html_track))
    end

    # Keep only 4 words (removing the featurings)
    def radio_name(html_track)
      html_track.parent.children[3].content.squish.
                                    sub(/( (ft|feat|featuring).+)\z/i, '').
                                    split(' ')[0..3].join(' ')
    end

    # Keep only the part before '/'
    def radio_artist(html_track)
      html_track.content.squish.sub(/\/(.+)\z/, '')
    end

    def played_at(html_track)
      Time.at(html_track.parent.parent['class'][/timestamp_(\d+)/,1].to_i)
    end
  end
end