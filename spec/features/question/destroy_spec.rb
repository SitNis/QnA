require 'rails_helper'

feature 'User can destroy his own question', %q{
  In order to stop discuss a question
  As an question author
  I'd like to be able to delete a question
} do

  given(:question) { create(:question) }
  given(:user) { create(:user) }

  describe 'Authenticated user' do
    scenario 'can delete his question' do
      sign_in(question.user)

      visit question_path(question)
      click_on 'Delete your question'

      expect(page).to have_content 'Question successfully deleted!'
    end

    scenario "can't delete not his question" do
      sign_in(user)

      visit question_path(question)
      click_on 'Delete your question'

      expect(page).to have_content 'You are not an author!'
    end
  end

  scenario 'Unauthenticated user' do
    visit question_path(question)
    click_on 'Delete your question'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end
