class AnswersController < ApplicationController
  include Voted
  include Commented

  before_action :authenticate_user!
  before_action :load_question, only: %i[create]
  before_action :load_answer, only: %i[destroy update best]

  after_action :publish_answer, only: %i[create]

  authorize_resource

  def create
    @answer = @question.answers.create(answer_params)
    current_user.answers << @answer
  end

  def destroy
    @answer.destroy
  end

  def update
    @answer.update(answer_params)
    @question = @answer.question
  end

  def best
    @question = @answer.question
    @answer.set_best
    @question.give_badge if @question.badge
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
      author_id: @answer.user.id,
      page: render_answer
      )
  end

  def render_answer
    ApplicationController.render(
      partial: 'answers/answer_for_channel',
      locals: {
        answer: @answer,
      }
    )
  end
end
