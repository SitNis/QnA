require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:answers).dependent(:destroy) }
  it { should have_many(:questions).dependent(:destroy) }
  it { should have_many(:badges).dependent(:destroy) }
  it { should have_many(:votes).dependent(:destroy) }
  it { should have_many(:subscribtions).dependent(:destroy) }

  it { should validate_presence_of :email }
  it { should validate_presence_of :password }

  let(:question) { create(:question) }
  let(:user) { create(:user) }
  let(:badge) { create(:badge, user: user, question: question) }

  it "check user is an author" do
    expect(question.user).to be_author_of(question)
  end

  it "check user isn't an author" do
    user = create(:user)

    expect(user).to_not be_author_of(question)
  end

  it 'check user already achive badge' do
    expect(user).to be_already_achived(badge)
  end
end
