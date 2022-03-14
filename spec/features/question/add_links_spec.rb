require 'rails_helper'

feature 'User can add links to question', %q{
  In order to provide additional info to my question
  As an question's author
  I'd like to be able to add links
} do

  given(:user) { create(:user) }
  given(:gist_url) { 'https://gist.github.com/SitNis/7bb571bc6ebe886a0397f2c2fc957f07' }
  given(:google_url) { 'http://google.com'}
  given(:question) { create(:question, user: user)}

  scenario 'User adds link when asks question' do
    sign_in(user)
    visit new_question_path

    fill_in 'Title', with: "Test question"
    fill_in 'Body', with: "text text text"

    fill_in 'Link name', with: 'Google'
    fill_in 'Url', with: google_url

    click_on 'Ask'

    expect(page).to have_link 'Google', href: google_url
  end

  scenario 'User adds gist when answer question', js: true do
    sign_in(user)
    visit new_question_path

    fill_in 'Title', with: "Test question"
    fill_in 'Body', with: "text text text"
    fill_in 'Link name', with: 'My gist'
    fill_in 'Url', with: gist_url

    click_on 'Ask'

    within '.question' do
      expect(page).to have_content 'test test'
    end
  end

  scenario 'user adds link when edit his question', js: true do
    sign_in(user)
    visit question_path(question)

    within '.question' do
      click_on 'Edit'
      click_on 'add link', match: :first

      fill_in 'Link name', with: 'Google'
      fill_in 'Url', with: google_url
    end

    click_on 'Save'

    expect(page).to have_link 'Google', href: google_url
  end
end
