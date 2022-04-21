# Preview all emails at http://localhost:3000/rails/mailers/question_subscribtion
class QuestionSubscribtionPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/question_subscribtion/new_answer
  def new_answer
    QuestionSubscribtionMailer.new_answer(User.first, Question.all[2])
  end

end
