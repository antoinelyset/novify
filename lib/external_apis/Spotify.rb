require 'meta-spotify'

module ExternalApis
  #TODO : Improve finding algorithm with variation and retry
  class Spotify
    def initialize(tracks = [])
      @tracks = tracks
    end

    def get_href
      @tracks.map do |t|
        track            = MetaSpotify::Track.search("#{t.radio_artist} #{t.radio_name}")[:tracks].first
        if track
          t.spotify_name   = track.name
          t.spotify_artist = track.artists.map(&:name).join(' - ')
          t.href           = track.uri[/\w+\z/]
        end
        t
      end
    end
  end
end
