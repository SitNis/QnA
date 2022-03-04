require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:answers).dependent(:destroy) }
  it { should have_many(:questions).dependent(:destroy) }

  it { should validate_presence_of :email }
  it { should validate_presence_of :password }

  let(:question) { create(:question) }

  it "check user is an author" do
    expect(question.user.author_of?(question)).to eq true
  end

  it "check user isn't an author" do
    user = create(:user)

    expect(user.author_of?(question)). to eq false
  end
end
