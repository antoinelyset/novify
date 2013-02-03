require 'test_helper'

class RadioTest < ActiveSupport::TestCase
  def test_the_validators
    nova = radios(:nova)
    nova_dup = nova.dup
    assert !nova_dup.save
    assert nova_dup.errors.added? :name, :taken
  end


  def test_it_has_radios
    assert radios(:nova).tracks.include? tracks(:one)
  end
end
