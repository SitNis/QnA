class AnswersController < ApplicationController
  include Voted

  before_action :authenticate_user!
  before_action :load_question, only: %i[create]
  before_action :load_answer, only: %i[destroy update best]

  after_action :publish_answer, only: %i[create]

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
    if current_user.author_of?(@answer)
      @answer.update(answer_params)
      @question = @answer.question
    end
  end

  def best
    @question = @answer.question
    if current_user.author_of?(@question)
      @answer.set_best
      @question.give_badge if @question.badge
    end
  end

  private

  def load_answer
    @answer = Answer.with_attached_files.find(params[:id])
  end

  def load_question
    @question = Question.find(params[:question_id])
  end

  def answer_params
    params.require(:answer).permit(:body, files: [], links_attributes: [:name, :url, :_destroy])
  end

  def publish_answer
    return if @answer.errors.any?
    ActionCable.server.broadcast(
      "answers_#{@answer.question.id}",
      ApplicationController.render(
        partial: 'answers/answer_for_channel',
        locals: {
          answer: @answer,
        }
      )
    )
  end
end
