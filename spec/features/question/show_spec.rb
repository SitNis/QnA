require 'rails_helper'

feature 'User can see the question discussion', %q{
  In order to see question solution
  As an unauthenticated user
  I'd like to be able to see question discussion
} do

  given(:question) { create(:question) }

  scenario 'see the question discussion' do
    visit question_path(question)

    expect(page).to have_content question.title
    expect(page).to have_content question.body
    expect(page).to have_content 'Answers:'
  end
end
