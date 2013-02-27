require 'test_helper'

class TracksHelperTest < ActionView::TestCase
  def test_track_player
    track_without_href = FactoryGirl.create(:track, href: nil)
    assert_equal  "", track_player(track_without_href)
  end
end
