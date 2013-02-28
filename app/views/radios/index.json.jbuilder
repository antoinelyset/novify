json.(@radios) do |json, radio|
  json.partial! "/radios/base", radio: radio
end