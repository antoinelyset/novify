module ExternalApis
  module Spotify

    def self.multiple_fetch(tracks)
      threads = []
      threads = tracks.map { |t| threaded_fetch(t.radio_name, t.radio_artist) }.each(&:join)
      threads.each_with_index do |th, i|
        track = tracks[i]
        track.spotify_name, track.spotify_artist, track.href = th[:spotify_track].to_a
      end
      tracks
    end

    def self.threaded_fetch(name = '', artist = '')
      Thread.new do
        Thread.current[:spotify_track] = fetch(name, artist)
      end
    end

    def self.fetch(name = '', artist = '')
      spotify_track = get_track(name, artist)
      yield(*spotify_track.to_a) if block_given?
      spotify_track
    end

    def self.get_track(name, artist)
      search       = "#{name} #{artist}"
      spotify_data = MetaSpotify::Track.search(search)[:tracks].first
      Track.new(spotify_data)
    end

    class Track
      attr_reader :name, :artist, :href
      def initialize(name = nil, artist = nil, href = nil)
        #Coercion
        if name.is_a?(Hash)
          @name, @artist, @href = name.values_at(:name, :artist, :href)
        elsif name.is_a?(MetaSpotify::Track)
          @name, @artist, @href = from_gem(name)
        else
          @name, @artist, @href = name, artist, href
        end
      end

      def to_h
        {name: name, artist: artist, href: href}
      end

      def to_a
        [name, artist, href]
      end

      def exist?
        return name && artist && href
      end
      alias_method :exists?, :exist?

    private
      def from_gem(spotify_data)
        [
          spotify_data.name,
          spotify_data.artists.map(&:name).join(' - '),
          spotify_data.uri[/\w+\z/]
        ]
      end
    end
  end
end