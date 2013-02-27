require 'test_helper'

class RadioTest < ActiveSupport::TestCase
  def test_the_name_uniqueness_validator
    radio = FactoryGirl.create(:radio)
    radio_copy = radio.dup
    assert !radio_copy.save
    assert radio_copy.errors.added? :name, :taken
  end

  def test_it_has_tracks
    radio = FactoryGirl.create(:radio)
    track = FactoryGirl.create(:track, radio: radio)
    assert radio.tracks.include? track
  end

  def test_it_sets_times
    radio = FactoryGirl.create(:radio)
    just_played_track = FactoryGirl.create(:track, radio: radio)
    old_played_track  = FactoryGirl.create(:track, played_at: Time.now - 20.days,
                                                   radio: radio)

    assert radio.started_at == old_played_track.played_at
    assert radio.ended_at   == just_played_track.played_at
  end
end
