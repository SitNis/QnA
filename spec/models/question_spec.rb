require 'rails_helper'

RSpec.describe Question, type: :model do
  it { should have_many(:answers).dependent(:destroy) }
  it { should have_many(:links).dependent(:destroy) }
  it { should have_many(:votes).dependent(:destroy) }
  it { should have_one(:badge).dependent(:destroy) }
  it { should belong_to :user }

  it { should validate_presence_of :title }
  it { should validate_presence_of :body }

  it { should accept_nested_attributes_for :links }
  it { should accept_nested_attributes_for :badge }

  let!(:question) { create(:question) }
  let!(:badge) { create(:badge, question: question) }
  let!(:user) { create(:user) }
  let(:answer) { create(:answer, question: question, user: user)}

  it 'have many attached files' do
    expect(Question.new.files).to be_an_instance_of(ActiveStorage::Attached::Many)
  end

  it 'gives a badge for best answer' do
    answer.set_best
    question.give_badge

    expect(user.badges.first).to eq(badge)
  end

  it 'can get vote' do
    question.vote(1, user)

    expect(question.votes.first).to be_an_instance_of(Vote)
  end

  it 'can cancel vote' do
    question.vote(1, user)
    question.cancel_vote(user)

    expect(question.votes.count).to eq(0)
  end

  it 'can count score' do
    question.vote(1, user)

    expect(question.score).to eq(1)
  end
end
