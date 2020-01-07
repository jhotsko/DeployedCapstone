class Workout < ApplicationRecord
  belongs_to :cadet
  validates :workoutType, :workoutdate, :repititions, :distance, :cadet_id, :presence => true
end
