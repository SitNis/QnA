require 'rails_helper'

feature 'User can destroy his own answer', %q{
  In order to delete wrong answer
  As an answer author
  I'd like to be able to delete an answer
} do

  given!(:answer) { create(:answer) }
  given(:user) { create(:user) }

  describe 'Authenticated user' do
    scenario 'can delete his answer' do
      sign_in(answer.user)

      visit question_path(answer.question)
      click_on 'Delete your answer'

      expect(page).to_not have_content answer.body
    end

    scenario "can't delete not his answer" do
      sign_in(user)
      visit question_path(answer.question)

      expect(page).to_not have_content 'Delete your answer'
    end
  end

  scenario 'Unauthenticated user' do
    visit question_path(answer.question)

    expect(page).to_not have_content 'Delete your answer'
  end
end
