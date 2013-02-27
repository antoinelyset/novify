FactoryGirl.define do

  sequence(:artist) {|n| "artist-#{n}" }
  sequence(:name)   {|n| "name-#{n}"   }
  sequence(:href)   {|n| "href-#{n}"   }

  factory :radio do
    name
  end

  factory :track do
    formatted_artist { generate(:artist) }
    formatted_name   { generate(:name) }
    spotify_artist   {|t| t.formatted_artist }
    spotify_name     {|t| t.formatted_name   }
    radio_artist     {|t| t.formatted_artist }
    radio_name       {|t| t.formatted_name   }
    played_at        { Time.now }
    radio
    href             { generate(:href) }
  end
end