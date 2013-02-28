module TracksHelper
  def tracks_player(tracks, title = "")
    found_tracks = tracks.select { |t| !t.href.nil? }
    tracks_element = found_tracks.reduce('') { |el, t| "#{t.href},#{el}" }.chop
    return "" if tracks_element.blank?
    player_height = 37*found_tracks.count+81
    "<iframe src=\"https://embed.spotify.com/?uri=spotify:trackset:#{title}:#{tracks_element}\"" +
            'width="620px"'                                                                      +
            "height='#{player_height}px'"                                                        +
            'frameborder="0"'                                                                    +
            'allowtransparency="true">'                                                          +
    '</iframe>'
  end

  def track_player(track)
    return "" if track.href.nil?
    "<iframe src=\"https://embed.spotify.com/?uri=spotify:track:#{track.href}\"" +
            'width="300px"'                                                      +
            'height="380px"'                                                     +
            'frameborder="0"'                                                    +
            'allowtransparency="true">'                                          +
    '</iframe>'
  end
end
