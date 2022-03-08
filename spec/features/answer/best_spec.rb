require 'rails_helper'

feature 'Question author can set the best answer', %q{
  In order to choose the most useful answer
  As an author of question
  I'd like to be able to set the best answer
} do

  given!(:user) { create(:user) }
  given!(:question) { create(:question, user: user) }
  given!(:answer) { create(:answer, question: question) }
  given(:not_author) { create(:user) }

  scenario 'Question author set the best answer', js: true do
    sign_in(user)
    visit question_path(question)

    click_on 'Best'

    within '.best-answer' do
      expect(page).to have_content answer.body
    end
  end

  scenario 'Not author tries to set the best answer' do
    sign_in(not_author)
    visit question_path(question)

    expect(page).to_not have_selector(:link_or_button, 'Best')
  end
end
