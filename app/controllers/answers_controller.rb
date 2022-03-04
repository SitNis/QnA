class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :load_question, only: %i[create]
  before_action :load_answer, only: %i[destroy]

  def create
    @answer = @question.answers.build(answer_params)
    current_user.answers << @answer

    if @answer.save
      redirect_to question_path(@question), notice: 'Your answer successfully created.'
    else
      render template: "questions/show"
    end
  end

  def destroy
    if current_user.author_of?(@answer)
      @answer.destroy
      redirect_to question_path(@answer.question), notice: 'Answer successfully deleted!'
    end
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
