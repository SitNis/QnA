require 'rails_helper'

feature 'User can see all questions', %q{
  In order to find interested question
  As an any user
  I'd like to see all questions
} do

  let!(:badges) { create_list(:badge, 2) }
  let!(:user) { create(:user) }

  scenario 'sees all questions' do
    user.badges << badges
    sign_in(user)

    visit badges_path

    expect(page).to have_content badges[0].title
    expect(page).to have_content badges[1].title
  end
end
