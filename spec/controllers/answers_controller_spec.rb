require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:question) { create(:question) }
  let(:user) { create(:user) }

  describe 'POST #create' do
    before { login(user) }

    context 'with valid attributes' do
      it 'saves a new answer in the database' do
        expect { post :create, params: { answer: attributes_for(:answer), question_id: question } }.to change(user.answers, :count).by(1)
      end

      it 'redirects to question' do
        post :create, params: { answer: attributes_for(:answer), question_id: question }
        expect(response).to redirect_to assigns(:question)
      end
    end

    context 'with invalid attributes' do
      it 'does not save the answer' do
        expect { post :create, params: { answer: attributes_for(:answer, :invalid), question_id: question } }.to_not change(question.answers, :count)
      end

      it 're-renders new view' do
        post :create, params: { answer: attributes_for(:answer, :invalid), question_id: question }
        expect(response).to render_template 'questions/show'
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:answer) { create(:answer) }

    context 'user is an author' do
      before { login(answer.user) }

      it 'deletes the answer' do
        expect { delete :destroy, params: { id: answer } }.to change(Answer, :count).by(-1)
      end

      it 'redirects to question' do
        show_question_after_delete(answer)
      end
    end

    context 'user is not an author' do
      before { login(user) }

      it "deletes not his answer" do
        expect { delete :destroy, params: { id: answer} }.to_not change(Answer, :count)
      end

      it 'redirects to question' do
        show_question_after_delete(answer)
      end
    end
  end
end
