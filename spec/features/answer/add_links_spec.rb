require 'rails_helper'

feature 'User can add links to answer', %q{
  In order to provide additional info to my answer
  As an answer's author
  I'd like to be able to add links
} do

  given(:user) { create(:user) }
  given(:question) { create(:question) }
  given!(:answer) { create(:answer, user: user, question: question)}
  given(:google_url) { 'http://google.com'}
  given(:gist_url) { 'https://gist.github.com/SitNis/7bb571bc6ebe886a0397f2c2fc957f07' }

  scenario 'User adds link when answer question', js: true do
    sign_in(user)
    visit question_path(question)

    fill_in 'Body', with: 'text text text'
    fill_in 'Link name', with: 'Google'
    fill_in 'Url', with: google_url

    click_on 'Answer'

    within '.answers' do
      expect(page).to have_link 'Google', href: google_url
    end
  end

  scenario 'User adds link when edit his answer', js: true do
    sign_in(user)
    visit question_path(question)

    within '.answers' do
      click_on 'Edit'
      click_on 'add link'

      fill_in 'Link name', with: 'Google'
      fill_in 'Url', with: google_url

      click_on 'Save'

      expect(page).to have_link 'Google', href: google_url
    end
  end
end
