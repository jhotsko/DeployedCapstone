class Grade < ApplicationRecord
  belongs_to :cadet
  belongs_to :warriorknowledge
    
  validates :num_correct, :cadet_id, :warriorknowledge_id, :presence => true
  
  def score
    @score = (self.num_correct.to_f / self.warriorknowledge.num_questions.to_f) * 100
    @score.round(2)
  end
end
