json.(track, :id, :radio_name, :radio_artist, :played_at)
json.found_on_spotify? !track.href.nil?
if track.href
  json.(track, :href, :spotify_name,   :spotify_artist)
  json.spotify_http_uri "http://open.spotify.com/track/#{track.href}"
  json.spotify_uri "spotify:track:#{track.href}"
end