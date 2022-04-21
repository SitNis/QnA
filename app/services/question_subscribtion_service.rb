class QuestionSubscribtionService
  def send_notification_to_subscribers(question)
    question.subscribtions.find_each(batch_size: 500) do |sub|
      QuestionSubscribtionMailer.new_answer(sub.user, sub.question).deliver_later
    end
  end
end
