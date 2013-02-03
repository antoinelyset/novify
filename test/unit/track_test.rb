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
    assert tracks(:two).valid?
  end

  def test_valid_one
    assert tracks(:one).valid?
  end

  def test_it_belongs_to_a_radio
    assert tracks(:one).radio == radios(:nova)
  end
end
