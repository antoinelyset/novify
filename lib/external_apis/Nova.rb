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
      doc = Nokogiri::HTML(open("http://www.novaplanet.com/radionova/cetaitquoicetitre/#{@timestamp}"))
      doc.xpath('//h2[@class="artiste"]').map do |t|
        track = Track.new(
                  radio_artist: t.content.squish,
                  radio_name: t.parent.children[3].content.squish,
                  played_at: Time.at(t.parent.parent['class'][/timestamp_(\d+)/,1].to_i)
                )
        track.reformat_radio_data
        @tracks << track
      end
    end
  end
end