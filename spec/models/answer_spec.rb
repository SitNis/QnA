require 'rails_helper'

RSpec.describe Answer, type: :model do
  it { should belong_to :question }
  it { should belong_to :user }

  it { should validate_presence_of :body }

  let!(:question) { create(:question) }
  let!(:answer) { create(:answer, question: question) }
  let(:second_answer) { create(:answer, question: question) }

  it 'should sets best answer' do
    answer.set_best

    expect(answer.best).to eq true
  end

  it 'should change best answer' do
    answer.set_best
    second_answer.set_best
    answer.reload

    expect(answer.best).to eq false
    expect(second_answer.best).to eq true
  end
end
