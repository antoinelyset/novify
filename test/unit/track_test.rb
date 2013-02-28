require 'test_helper'

class TrackTest < ActiveSupport::TestCase
  def test_the_validators
    empty_track =  Track.new

    assert !empty_track.valid?
    assert empty_track.errors.count == 4
    [:played_at, :radio_name, :radio_artist, :radio].each do |att|
      assert empty_track.errors.added? att, :blank
    end
  end

  def test_without_spotify_data
    track_without_spotify = FactoryGirl.create(:track,  spotify_artist: nil,
                                                        spotify_name: nil,
                                                        href: nil)

    assert track_without_spotify.valid?
  end

  def test_valid_track_with_spotify

    track = FactoryGirl.create(:track)
    assert track.valid?
  end

  def test_it_belongs_to_a_radio
    radio = FactoryGirl.create(:radio)
    track = FactoryGirl.create(:track, radio: radio)

    assert track.radio == radio
  end

  def test_it_update_radio_times
    radio = FactoryGirl.create(:radio)
    just_played_track = FactoryGirl.create(:track, radio: radio)
    old_played_track  = FactoryGirl.create(:track, played_at: Time.now - 20.days,
                                                   radio: radio)

    assert just_played_track.played_at == radio.ended_at
    assert old_played_track.played_at  == radio.started_at
  end
end
