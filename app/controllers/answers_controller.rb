class AnswersController < ApplicationController
  before_action :authenticate_user!

  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.build(answer_params)

    if @answer.save
      redirect_to question_path(@question), notice: 'Your answer successfully created.'
    else
      render template: "questions/show"
    end
  end

  private
  def answer_params
    params.require(:answer).permit(:body)
  end
end
