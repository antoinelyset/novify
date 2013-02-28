json.(track, :id, :radio_name, :radio_artist, :played_at)
json.found_on_spotify? !track.href.nil?
if track.href
  json.(track, :href, :spotify_name,   :spotify_artist)
end