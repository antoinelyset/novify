module TracksHelper
  def generate_embed_player(track)
    "<iframe src=\"https://embed.spotify.com/?uri=spotify:track:#{track.href}\"" +
            'width="500"'                                                      +
            'height="80"'                                                      +
            'frameborder="0"'                                                  +
            'allowtransparency="true">'                                        +
    '</iframe>'
  end
end
