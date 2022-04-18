class Api::V1::AnswersController < Api::V1::BaseController
  before_action :load_answer, only: %i[show destroy update]
  before_action :load_question, only: %i[index create]

  authorize_resource

  def index
    render json: @question.answers
  end

  def show
    render json: @answer
  end

  def create
    @answer = @question.answers.build(answer_params)
    @answer.user = current_resource_owner

    if @answer.save
      render json: @answer
    else
      head :unprocessable_entity
    end
  end

  def destroy
    @answer.destroy
  end

  def update
    if @answer.update(answer_params)
      render json: @answer
    else
      head :unprocessable_entity
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:body, files: [], links_attributes: [:name, :url, :_destroy])
  end

  def load_answer
    @answer = Answer.with_attached_files.find(params[:id])
  end

  def load_question
    @question = Question.find(params[:question_id])
  end
end
