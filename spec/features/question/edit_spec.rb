require 'rails_helper'

feature 'User can edit his question', %q{
  In order to correct mistakes
  As an author of question
  I'd like to be able to edit my question
} do

  given!(:question) { create(:question) }
  given(:user) { create(:user) }

  scenario 'Unauthenticated can not edit answer' do
    visit question_path(question)

    expect(page).to_not have_link 'Edit'
  end

  describe 'Authenticated user' do
    scenario 'edits his question', js: true do
      sign_in(question.user)
      visit question_path(question)

      click_on 'Edit'

      within '.question' do
        fill_in 'Your question title', with: 'edited question title'
        fill_in 'Your question body', with: 'edited question body'
        click_on 'Save'

        expect(page).to_not have_content question.body
        expect(page).to_not have_content question.title
        expect(page).to have_content 'edited question title'
        expect(page).to have_content 'edited question body'
      end
    end

    scenario 'add files to his answer', js: true do
      sign_in(question.user)
      visit question_path(question)

      click_on 'Edit'

      within '.question' do
        attach_file 'File', ["#{Rails.root}/spec/rails_helper.rb", "#{Rails.root}/spec/spec_helper.rb"]
        click_on "Save"

        expect(page).to have_link 'spec_helper.rb'
        expect(page).to have_link 'rails_helper.rb'
      end
    end

    scenario 'edits his question with errors', js: true do
      sign_in(question.user)
      visit question_path(question)

      click_on 'Edit'

      within '.question' do
        fill_in 'Your question body', with: ''
        click_on 'Save'

        expect(page).to have_content question.body
      end
      expect(page).to have_content "Body can't be blank"
    end

    scenario "tries to edit other user's answer" do
      sign_in(user)
      visit question_path(question)

      within '.answers' do
        expect(page).to_not have_content 'Edit'
      end
    end
  end
end
