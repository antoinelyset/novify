json.partial! "/radios/base", radio: @radio

json.tracks @radio.tracks do |json, track|
  json.partial! "/tracks/show", track: track
end