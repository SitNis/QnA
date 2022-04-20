class Question < ApplicationRecord
  include Votable
  include Commentable

  has_many :answers, dependent: :destroy
  has_many :links, dependent: :destroy, as: :linkable
  has_one :badge, dependent: :destroy
  has_many :subscribtions, dependent: :destroy
  belongs_to :user

  has_many_attached :files

  accepts_nested_attributes_for :links, reject_if: :all_blank
  accepts_nested_attributes_for :badge, reject_if: :all_blank

  validates :title, presence: true
  validates :body, presence: true

  after_create :subscribe_author

  def best_answer
    answers.find_by(best: true)
  end

  def give_badge
    if !best_answer&.user.already_achived?(self.badge)
      best_answer.user.badges << self.badge
    end
  end

  private

  def subscribe_author
    user.subscribtions.build(question: self).save
  end
end
