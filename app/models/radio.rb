class Radio < ActiveRecord::Base
  validate :ended_at_cannot_be_before_started_at
  has_many :tracks

  attr_accessible :ended_at, :started_at, :name, :tracks

  validates_uniqueness_of :name
  validates_uniqueness_of :ended_at, :started_at, :scope => :name

private
  def ended_at_cannot_be_before_started_at
    return unless ended_at && started_at
     if ended_at < started_at
       errors.add(:ended_at, "can't be before Started_at")
     end
  end
end