class QuestionSubscribtionJob < ApplicationJob
  queue_as :default

  def perform(question)
    QuestionSubscribtionService.new.send_notification_to_subscribers(question)
  end
end
