class Radio < ActiveRecord::Base
  before_save :set_times
  has_many :tracks

  attr_accessible :ended_at, :started_at, :name, :tracks

  validates_uniqueness_of :name
  validates_uniqueness_of :ended_at, :started_at, :scope => :name

  # Calculate Start and End on save callback
  private
    def set_times
      self.started_at = self.tracks.last.played_at
      self.ended_at   = self.tracks.first.played_at
    end
end
