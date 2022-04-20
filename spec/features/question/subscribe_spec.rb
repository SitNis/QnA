require 'rails_helper'

feature 'User can subscribe to question', %q{
  In order to get notification about new answers
  As an authenticated user
  I'd like to be able to subscribe to question
} do

  given!(:question) { create(:question) }
  given(:user) { create(:user) }

  describe 'Unauthenticated user' do
    scenario 'tries to subscribe' do
      visit question_path(question)

      within '.question' do
        expect(page).to_not have_content 'Subscribe'
      end
    end

    scenario 'tries to unsubscribe' do
      visit question_path(question)

      within '.question' do
        expect(page).to_not have_content 'Unsubscribe'
      end
    end
  end

  describe 'Authenticated user', js: true do
    before { sign_in(user) }

    scenario 'subscribe to question' do
      visit question_path(question)

      within '.question' do
        click_on 'Subscribe'

        expect(page).to_not have_content 'Subscribe'
        expect(page).to have_link 'Unsubscribe'
      end
    end

    scenario 'unsubscribe question' do
      visit question_path(question)

      within '.question' do
        click_on 'Subscribe'
        click_on 'Unsubscribe'

        expect(page).to_not have_link 'Unsubscribe'
        expect(page).to have_link 'Subscribe'
      end
    end
  end
end
