require 'rails_helper'

feature 'User can vote for question', %q{
  In order to estimate question
  As an authenticated user
  I'd like to be able to vote for question
} do

  given!(:question) { create(:question) }
  given(:user) { create(:user) }
  given!(:user_question) { create(:question, user: user)}


  scenario 'Unauthenticated can not vote for question' do
    visit question_path(question)

    within '.question' do
      expect(page).to_not have_link 'Like'
      expect(page).to_not have_link 'Dislike'
      expect(page).to_not have_link 'Cancel vote'
    end
  end

  scenario 'Author of answer can not vote for it' do
    sign_in(user)
    visit question_path(user_question)

    within '.question' do
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

    scenario 'can like the question' do
      within '.votes' do
        click_on 'Like'

        expect(page).to have_content('1')
      end
    end

    scenario 'can dislike the question' do
      within '.votes' do
        click_on 'Dislike'

        expect(page).to have_content('-1')
      end
    end

    scenario 'can cancel vote for the question' do
      within '.votes' do
        click_on 'Dislike'
        click_on 'Cancel vote'

        expect(page).to have_content('0')
      end
    end
  end
end
