require 'rails_helper'

feature 'User can delete question links', %q{
  In order to delete additional info of his question
  As an question's author
  I'd like to be able to delete links
} do

  given!(:user) { create(:user) }
  given!(:second_user) { create(:user) }
  given(:question) { create(:question, user: user) }
  given(:google_url) { 'http://google.com'}

  background do
    sign_in(user)
    visit question_path(question)

    within '.question' do
      click_on 'Edit'
      click_on 'add link', match: :first

      fill_in 'Link name', with: 'Google'
      fill_in 'Url', with: google_url
    end

    click_on 'Save'
  end

  scenario 'Author delete answer links', js: true do
    within '.question' do
      expect(page).to have_link 'Google', href: google_url
      click_on 'Delete'
      expect(page).to_not have_link 'Google', href: google_url
    end
  end

  scenario 'Not an author tries delete answer links', js: true do
    click_on 'Log out'

    sign_in(second_user)
    visit question_path(question)

    within '.question' do
      expect(page).to_not have_link 'Delete'
    end
  end
end
