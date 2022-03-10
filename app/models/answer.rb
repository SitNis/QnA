class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user

  has_many_attached :files

  validates :body, presence: true

  def set_best
    if self.question.best_answer
      self.question.best_answer.update(best: false)
      self.update(best: true)
    else
      self.update(best: true)
    end
  end
end
