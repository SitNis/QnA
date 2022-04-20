class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :questions, dependent: :destroy
  has_many :answers, dependent: :destroy
  has_many :badges, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :subscribtions, dependent: :destroy

  def author_of?(model)
    id == model.user_id
  end

  def already_achived?(badge)
    self.badges.exists?(badge.id)
  end

  def subscribed(question)
    subscribtions.find_by(question: question)
  end

  def subscribed?(question)
    !!subscribtions.find_by(question: question)
  end
end
