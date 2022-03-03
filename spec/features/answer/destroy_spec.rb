require 'rails_helper'

feature 'User can destroy his own answer', %q{
  In order to delete wrong answer
  As an answer author
  I'd like to be able to delete an answer
} do

  given(:question) { create(:question) }
  given(:user) { create(:user) }

  describe 'Authenticated user' do
    scenario 'can delete his answer' do
      sign_in(question.user)

      visit question_path(question)
      fill_in 'Body', with: 'text text'
      click_on 'Answer'

      click_on 'Delete your answer'

      expect(page).to have_content 'Answer successfully deleted!'
    end

    scenario "can't delete not his answer" do
      sign_in(user)
      visit question_path(question)

      expect(page).to_not have_content 'Delete your answer'
    end
  end

  scenario 'Unauthenticated user' do
    visit question_path(question)

    expect(page).to_not have_content 'Delete your answer'
  end
end
