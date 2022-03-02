class QuestionsController < ApplicationController
  expose :questions, -> { Question.all }
  expose :question
  before_action :authenticate_user!, except: %i[index show]

  def create
    @question = Question.new(question_params)

    if @question.save
      redirect_to @question, notice: 'Your question successfully created.'
    else
      render :new
    end
  end

  def update
    @question = question

    if @question.update(question_params)
      redirect_to @question
    else
      render :edit
    end
  end

  def destroy
    question.destroy
    redirect_to questions_path
  end

  private

  def question_params
    params.require(:question).permit(:title, :body)
  end
end
