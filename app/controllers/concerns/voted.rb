module Voted
  extend ActiveSupport::Concern

  included do
    before_action :load_votable, only: %i[like dislike cancel_vote]
  end

  def like
  end

  def dislike
  end

  def cancel_vote
  end

  private

  def model_klass
    controller_name.classify.constantize
  end

  def load_votable
    @votable = model_klass.find(params[:id])
  end
end
