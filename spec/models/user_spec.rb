require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:answers).dependent(:destroy) }
  it { should have_many(:questions).dependent(:destroy) }

  it { should validate_presence_of :email }
  it { should validate_presence_of :password }

  let(:question) { create(:question) }

  it "check user is an author" do
    expect(question.user).to be_author_of(question)
  end

  it "check user isn't an author" do
    user = create(:user)

    expect(user).to_not be_author_of(question)
  end
end
