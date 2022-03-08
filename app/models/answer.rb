class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user

  validates :body, presence: true

  def set_best(question)
    if question.best_answer
      question.best_answer.update(best: false)
      self.update(best: true)
    else
      self.update(best: true)
    end
  end
end
