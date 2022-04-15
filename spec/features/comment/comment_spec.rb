require 'rails_helper'

feature 'User can comment', %q{
  In order to write additional info
  As an authenticated user
  I'd like to be able to comment
} do

  given!(:user) { create(:user) }
  given!(:question) { create(:question, user: user) }
  given!(:answer) { create(:answer, question: question) }

  describe "Authenticated user", js: true do
    background do
      sign_in(user)

      visit question_path(question)
    end

    scenario 'create comment' do
      within ".new-comment-#{question.id}" do
        fill_in "comment-body#{question.id}", with: 'text text text'

        click_on 'Add comment'
      end

      within '.comments' do
        expect(page).to have_content 'text text text'
      end
    end

    scenario "comment appears on another user's page" do
      Capybara.using_session('user') do
        sign_in(user)
        visit question_path(question)
      end

      Capybara.using_session('quest') do
        visit question_path(question)
      end

      Capybara.using_session('user') do
        within ".new-comment-#{question.id}" do
          fill_in "comment-body#{question.id}", with: 'text text text'

          click_on 'Add comment'
        end
      end

      Capybara.using_session('quest') do
        within '.comments' do
          expect(page).to have_content 'text text text'
        end
      end
    end
  end
end
