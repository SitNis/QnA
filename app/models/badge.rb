class Badge < ApplicationRecord
  belongs_to :question
  belongs_to :user, optional: true

  validates :title, presence: true
  has_one_attached :image
end
