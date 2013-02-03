class Radio < ActiveRecord::Base
  has_many :tracks

  attr_accessible :end_time, :start_time, :name, :tracks

  validates_uniqueness_of :name
  validates_uniqueness_of :end_time, :start_time, :scope => :name

  # Calculate Start and End on save callback
end
