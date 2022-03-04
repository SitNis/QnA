require 'rails_helper'

feature 'User can see the question discussion', %q{
  In order to see question solution
  As an unauthenticated user
  I'd like to be able to see question discussion
} do

  given(:answer) { create(:answer) }

  scenario 'see the question discussion' do
    visit question_path(answer.question)

    expect(page).to have_content answer.question.title
    expect(page).to have_content answer.question.body
    expect(page).to have_content answer.body
  end
end
