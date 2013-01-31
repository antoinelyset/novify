class Playlist < ActiveRecord::Base
  has_and_belongs_to_many :tracks

  attr_accessible :end_time, :start_time, :name, :tracks

  validates_uniqueness_of :name
  validates_uniqueness_of :end_time, :start_time, :scope => :name
end
