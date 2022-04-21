require 'rails_helper'

RSpec.describe QuestionSubscribtionJob, type: :job do
  let(:service) { double('QuestionSubscribtionService') }
  let(:question) { create(:question) }

  before do
    allow(QuestionSubscribtionService).to receive(:new).and_return(service)
  end

  it 'calls QuestionSubscribtion#send_notification_to_subscribers' do
    expect(service).to receive(:send_notification_to_subscribers).with(question)
    QuestionSubscribtionJob.perform_now(question)
  end
end
