require 'rails_helper'

RSpec.describe LinksController, type: :controller do
  let(:user) { create(:user) }
  let(:second_user) { create(:user) }

  describe 'DELETE #destroy' do
    let(:question) { create(:question, user: user) }
    let!(:link) { create(:link, linkable: question) }

    context 'user is an author' do
      before { sign_in(user) }

      it 'deletes link' do
        expect { delete :destroy, params: { id: question.links.first.id}, format: :js }.to change(question.links, :count).by(-1)
      end
    end

    context 'user is not an author' do
      before { sign_in(second_user) }

      it "doesn't deletes link" do
        expect { delete :destroy, params: { id: question.links.first.id}, format: :js }.to_not change(question.links, :count)
      end
    end
  end
end
