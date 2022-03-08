class Question < ApplicationRecord
  has_many :answers, dependent: :destroy
  belongs_to :user

  validates :title, presence: true
  validates :body, presence: true

  def best_answer
    answers.find_by(best: true)
  end
end
