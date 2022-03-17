require 'rails_helper'

RSpec.describe BadgesController, type: :controller do
  describe 'GET #index' do
    let(:user) { create(:user) }
    let(:badges) { create_list(:badge, 3) }

    before do
      login(user)
      user.badges << badges
      get :index
    end

    it 'populates an array of all user badges' do
      expect(assigns(:badges)).to match_array(badges)
    end

    it 'renders index view' do
      expect(response).to render_template :index
    end
  end
end
