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

  def test_ended_at_cannot_be_before_started_at
    radio = FactoryGirl.build(:radio, ended_at: Time.now-1.day,
                                      started_at: Time.now)

    assert !radio.valid?
    assert radio.errors.added? :ended_at, "can't be before started_at"
  end

  def test_save_with_tracks
    radio = FactoryGirl.build(:radio)
    built_tracks = FactoryGirl.build_list(:track, 25, radio: radio)
    radio.save_with_tracks(built_tracks)

    # It saved the radio
    assert radio.persisted?
    # It save the tracks
    assert built_tracks.map(&:persisted?).uniq == [true]
  end

  def test_tracks_dependent_destroy
    radio = FactoryGirl.create(:radio)
    radio_tracks_number = 25
    FactoryGirl.create_list(:track, radio_tracks_number, radio: radio)
    before_destroy_tracks_number = Track.count
    radio.destroy

    assert Track.count == before_destroy_tracks_number - radio_tracks_number
  end
end
