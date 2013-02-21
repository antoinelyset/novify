require 'nokogiri'
require 'open-uri'

module ExternalApis
  class Nova
    attr_accessor :timestamp, :tracks
    #Initialize with a timestamp
    def initialize(timestamp = Time.now.to_i)
      @timestamp  = timestamp
      @tracks = []
      fetch
    end

    #Return 20 which are around the timestamp
    def fetch
      fetch_tracks.map do |t|
        track = extract_track(t)
        @tracks << track
      end
    end

  private
    def fetch_tracks
      doc = Nokogiri::HTML(open("http://www.novaplanet.com/radionova/cetaitquoicetitre/#{@timestamp}"))
      doc.xpath('//h2[@class="artiste"]')
    end

    def extract_track(html_track)
      track = Track.new(
                radio_artist: html_track.content.squish,
                radio_name: html_track.parent.children[3].content.squish,
                played_at: extract_played_at(html_track)
      )
      track.reformat_radio_data
    end

    def extract_played_at(html_track)
      Time.at(html_track.parent.parent['class'][/timestamp_(\d+)/,1].to_i
    end
  end
end