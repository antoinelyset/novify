require 'nokogiri'
require 'open-uri'

module ExternalApis
  class Nova
    #Initialize with a timestamp
    def initialize(timestamp = Time.now.to_i)
      @timestamp = timestamp
      # html_tracks.first['class'][/timestamp_(\d+)/,1] #Extract timestamp
    end
    #Return 20 which are around the timestamp
    def get_tracks
      doc        = Nokogiri::HTML(
        open("http://www.novaplanet.com/radionova/cetaitquoicetitre/#{@timestamp}"))
      #html_tracks = doc.xpath('//div[starts-with(@class, "timestamp_")]').first
      doc.xpath('//h2[@class="artiste"]').map do |t|
        Track.new(radio_artist: t.content.squish,
                  radio_name: t.parent.children[3].content.squish)
                  ##Time.at(t.parent.parent['class'][/timestamp_(\d+)/,1].to_i)
      end
    end

  private
  #TODO : Reformat track, remove /
    def reformat_track(track)
      track.name
    end
  end
end