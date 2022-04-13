class QuestionsController < ApplicationController
  include Voted

  before_action :load_question, only: %i[show edit update destroy]
  before_action :authenticate_user!, except: %i[index show]

  after_action :publish_question, only: %i[create]

  def index
    @questions = Question.all
  end

  def new
    @question = Question.new()
    @question.links.build
    @question.build_badge
  end

  def create
    @question = current_user.questions.build(question_params)

    if @question.save
      redirect_to @question, notice: 'Your question successfully created.'
    else
      render :new
    end
  end

  def update
    @question.update(question_params)
  end

  def destroy
    if current_user.author_of?(@question)
      @question.destroy
      redirect_to questions_path, notice: 'Question successfully deleted!'
    else
      redirect_to @question, notice: 'You are not an author'
    end
  end

  def show
    @answer = Answer.new()
    @answer.links.build
  end

  private

  def load_question
    @question = Question.with_attached_files.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body,
                                      files: [], links_attributes: [:name, :url, :_destroy],
                                      badge_attributes: [:title, :image])
  end

  def publish_question
    return if @question.errors.any?
    ActionCable.server.broadcast(
      'questions',
      ApplicationController.render(
        partial: 'questions/question',
        locals: { question: @question }
      )
    )
  end
end
