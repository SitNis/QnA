require 'rails_helper'

feature 'User can delete answer links', %q{
  In order to delete additional info of my answer
  As an answer's author
  I'd like to be able to delete links
} do

  given!(:user) { create(:user) }
  given!(:second_user) { create(:user) }
  given(:question) { create(:question) }
  given(:google_url) { 'http://google.com'}

  background do
    sign_in(user)
    visit question_path(question)

    fill_in 'Body', with: 'text text text'
    fill_in 'Link name', with: 'Google'
    fill_in 'Url', with: google_url

    click_on 'Answer'
  end

  scenario 'Author delete answer links', js: true do
    within '.answers .links' do
      expect(page).to have_link 'Google', href: google_url
      click_on 'Delete'
      expect(page).to_not have_link 'Google', href: google_url
    end
  end

  scenario 'Not an author tries delete answer links', js: true do
    click_on 'Log out'

    sign_in(second_user)
    visit question_path(question)

    within '.answers .links' do
      expect(page).to_not have_link 'Delete'
    end
  end
end
