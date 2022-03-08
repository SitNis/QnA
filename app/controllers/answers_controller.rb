class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :load_question, only: %i[create]
  before_action :load_answer, only: %i[destroy update best]

  def create
    @answer = @question.answers.create(answer_params)
    current_user.answers << @answer
  end

  def destroy
    if current_user.author_of?(@answer)
      @answer.destroy
    end
  end

  def update
    @answer.update(answer_params)
    @question = @answer.question
  end

  def best
    @question = @answer.question
    @answer.set_best(@question)
  end

  private

  def load_answer
    @answer = Answer.find(params[:id])
  end

  def load_question
    @question = Question.find(params[:question_id])
  end

  def answer_params
    params.require(:answer).permit(:body)
  end
end
