require 'rails_helper'

feature 'User can see all questions', %q{
  In order to find interested question
  As an any user
  I'd like to see all questions
} do

  let!(:questions) { create_list(:question, 2) }

  scenario 'sees all questions' do
    visit questions_path

    expect(page).to have_content questions[0].title
    expect(page).to have_content questions[1].title
  end
end
