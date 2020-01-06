class Otsc < ApplicationRecord
  belongs_to :cadet
  validates :date, :description, :cadet_id, :presence => true
end
