require 'meta-spotify'

module ExternalApis
  #TODO : Improve finding algorithm with variation and retry
  class Spotify
    attr_accessor :tracks

    def initialize(tracks = [])
      @tracks = tracks
      fetch_tracks
    end

  private
    def fetch_tracks
      threads = []
      @tracks.each do |t|
        threads << Thread.new do
          Thread.current[:spotify_track] = MetaSpotify::Track.search("#{t.formatted_name} #{t.formatted_artist}")[:tracks].first
        end
      end
      extract_tracks(threads)
      @tracks
    end

    def extract_tracks(threads)
      threads.each_with_index do |thread, i|
        thread.join
        # TODO : Don't next, relaunch it with just the title,
        #   fuzzy match on each artist, then keep the highest
        next if thread[:spotify_track].nil?
        @tracks[i].attributes = extract_track(thread[:spotify_track])
      end
    end

    def extract_track(spotify_track)
      {
        spotify_name: spotify_track.name,
        spotify_artist: spotify_track.artists.map(&:name).join(' - '),
        href: spotify_track.uri[/\w+\z/]
      }
    end
  end
end
