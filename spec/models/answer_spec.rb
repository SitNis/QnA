require 'rails_helper'

RSpec.describe Answer, type: :model do
  it { should belong_to :question }
  it { should belong_to :user }
  it { should have_many(:links).dependent(:destroy) }
  it { should have_many(:votes).dependent(:destroy) }

  it { should validate_presence_of :body }

  it { should accept_nested_attributes_for :links }

  let!(:question) { create(:question) }
  let!(:answer) { create(:answer, question: question) }
  let(:second_answer) { create(:answer, question: question) }

  it 'have many attached files' do
    expect(Answer.new.files).to be_an_instance_of(ActiveStorage::Attached::Many)
  end

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
