require 'rails_helper'

RSpec.describe QuestionSubscribtionService do
  let!(:users) { create_list(:user, 2) }
  let!(:question) { create(:question, user: users.first) }
  let!(:subscribtion) { create(:subscribtion, user: users.last, question: question) }

  it 'sends new answer notification to all subscribed users' do
    users.each { |user| expect(QuestionSubscribtionMailer).to receive(:new_answer).with(user, question).and_call_original }
    subject.send_notification_to_subscribers(question)
  end
end
