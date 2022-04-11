require 'rails_helper'

RSpec.describe Vote, type: :model do
  it { should belong_to :votable }
  it { should belong_to :user }

  let(:user) { create(:user) }

  describe '#validate_author_of_votable' do
    context 'author' do
      let(:question) { create(:question, user: user) }

      it 'should raise error if tries to vote' do
        expect{ create(:vote, user: user, votable: question) }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    context 'not author' do
      let(:question) { create(:question) }

      it "shouldn't raise error if tries to vote" do
        expect{ create(:vote, user: user, votable: question) }.to_not raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end
end
