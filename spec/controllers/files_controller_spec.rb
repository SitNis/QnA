require 'rails_helper'

RSpec.describe FilesController, type: :controller do
  let(:user) { create(:user) }
  let(:second_user) { create(:user) }

  describe 'DELETE #destroy' do
    let(:question) { create(:question, user: user) }
    context 'user is an author' do
      before { sign_in(user) }

      it 'deletes file' do
        question.files.attach(io: File.open("#{Rails.root}/spec/rails_helper.rb"), filename: 'rails_helper.rb')
        expect { delete :destroy, params: { id: question.files.first.id}, format: :js }.to change(question.files, :count).by(-1)
      end
    end

    context 'user is not an author' do
      before { sign_in(second_user) }

      it "doesn't deletes file" do
        question.files.attach(io: File.open("#{Rails.root}/spec/rails_helper.rb"), filename: 'rails_helper.rb')
        expect { delete :destroy, params: { id: question.files.first.id}, format: :js }.to_not change(question.files, :count)
      end
    end
  end
end
