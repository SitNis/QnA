module Votable
  extend ActiveSupport::Concern

  included do
    has_many :votes, dependent: :destroy, as: :votable
  end

  def vote(value, user)
    if !already_voted?(user)
      votes.create(value: value, user: user)
    else
      cancel_vote(user)
      votes.create(value: value, user: user)
    end
  end

  def cancel_vote(user)
    vote = votes.find_by(user: user)
    vote.destroy if vote
  end

  def score
    votes.sum(:value)
  end

  private

  def already_voted?(user)
    !!votes.find_by(user: user)
  end
end
