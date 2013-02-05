module TracksHelper
  def generate_embed_player(tracks)
    found_tracks = tracks.select { |t| !t.href.nil? }
    tracks_element = found_tracks.reduce('') { |el, t| "#{t.href},#{el}" unless t.href.nil?  }.slice(0..-2)
    player_height = 37*found_tracks.count+80
    "<iframe src=\"https://embed.spotify.com/?uri=spotify:trackset:Nova:#{tracks_element}\"" +
            'width="640px"'                                                      +
            "height='#{player_height}px'"                                                  +
            'frameborder="0"'                                                  +
            'allowtransparency="true">'                                        +
    '</iframe>'
  end
end
