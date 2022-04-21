class QuestionSubscribtionMailer < ApplicationMailer
  def new_answer(user, question)
    @new_answer = question.answers.last
    @question = question

    mail to: user.email
  end
end
