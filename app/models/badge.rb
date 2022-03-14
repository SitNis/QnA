class Badge < ApplicationRecord
  belongs_to :question
  belongs_to :user, optional: true

  validates :title, :image, presence: true
  has_one_attached :image
end
