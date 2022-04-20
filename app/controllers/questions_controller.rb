class QuestionsController < ApplicationController
  include Voted
  include Commented

  before_action :load_question, only: %i[show edit update destroy subscribe unsubscribe]
  before_action :authenticate_user!, except: %i[index show]

  after_action :publish_question, only: %i[create]

  authorize_resource

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
    @question.destroy
    redirect_to questions_path, notice: 'Question successfully deleted!'
  end

  def show
    @answer = Answer.new()
    @answer.links.build
  end

  def subscribe
    if !current_user.subscribed?(@question)
      @subscribtion = current_user.subscribtions.build(question: @question)
      @subscribtion.save
    end
  end

  def unsubscribe
    current_user.subscribed(@question).destroy if current_user.subscribed?(@question)
  end

  private

  def load_question
    @question = Question.with_attached_files.find(params[:id])

    gon.question_id = @question.id
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
        locals: { question: @question,
                  current_user: current_user
                }
      )
    )
  end
end
