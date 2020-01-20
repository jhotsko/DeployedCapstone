class Warriorknowledge < ApplicationRecord
  has_many :grades, dependent: :destroy
  has_many :cadets, through: :grades
  accepts_nested_attributes_for :grades
end
