class SubscribtionsController < ApplicationController
  before_action :load_question, only: %i[create]

  authorize_resource

  def create
    if !current_user.subscribed?(@question)
      @subscribtion = current_user.subscribtions.build(question: @question)
      @subscribtion.save
    end
  end

  def destroy
    @subscribtion = Subscribtion.find(params[:id])

    @subscribtion.destroy
  end

  private

  def load_question
    @question = Question.with_attached_files.find(params[:question_id])
  end
end
