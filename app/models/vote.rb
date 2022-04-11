class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :votable, polymorphic: true

  validate :validate_author_of_votable

  private

  def validate_author_of_votable
    errors.add :base, :invalid, message: 'Author can not vote' if user&.author_of?(votable)
  end
end
