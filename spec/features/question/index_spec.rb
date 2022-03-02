require 'rails_helper'

feature 'User can see all questions', %q{
  In order to find interested question
  As an any user
  I'd like to see all questions
} do

  given(:user) { create(:user) }

  describe 'Any user' do
    scenario 'sees all questions' do
      visit questions_path

      expect(page).to have_content 'Questions'
    end
  end
end
