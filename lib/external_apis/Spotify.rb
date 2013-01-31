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

    def generate_embed_player(track_id)
      "<iframe src=\"https://embed.spotify.com/?uri=spotify:track:#{track_id}\"" +
              'width="300"'                                                      +
              'height="80"'                                                      +
              'frameborder="0"'                                                  +
              'allowtransparency="true">'                                        +
      '</iframe>'
    end
  end
end
