require 'rails_helper'

feature 'User can vote for answer', %q{
  In order to estimate answer
  As an authenticated user
  I'd like to be able to vote for answer
} do

  given!(:question) { create(:question) }
  given!(:answer) { create(:answer, question: question) }
  given(:user) { create(:user) }
  given!(:user_answer) { create(:answer, question: question, user: user)}


  scenario 'Unauthenticated can not vote for answer' do
    visit question_path(question)

    within '.answers' do
      expect(page).to_not have_link 'Like'
      expect(page).to_not have_link 'Dislike'
      expect(page).to_not have_link 'Cancel vote'
    end
  end

  scenario 'Author of answer can not vote for it' do
    sign_in(user)
    visit question_path(question)

    within ".answers ##{user_answer.id}" do
      expect(page).to_not have_link 'Like'
      expect(page).to_not have_link 'Dislike'
      expect(page).to_not have_link 'Cancel vote'
    end
  end

  describe 'Authenticated user' do
    background do
      sign_in(user)
      visit question_path(question)
    end

    scenario 'can like the answer' do
      within '.answers' do
        click_on 'Like'

        expect(page).to have_content('1')
      end
    end

    scenario 'can dislike the answer' do
      within '.answers' do
        click_on 'Dislike'

        expect(page).to have_content('-1')
      end
    end

    scenario 'can cancel vote for the answer' do
      within '.answers' do
        click_on 'Dislike'
        click_on 'Cancel vote'

        expect(page).to have_content('0')
      end
    end
  end
end
