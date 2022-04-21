# frozen_string_literal: true

class Ability
  include CanCan::Ability

  attr_reader :user

  def initialize(user)
    @user = user

    if user
      user.admin? ? admin_abilities : user_abilities
    else
      guest_abilities
    end
  end

  def guest_abilities
    can :read, :all
  end

  def admin_abilities
    can :manage, :all
  end

  def user_abilities
    guest_abilities
    can :create, [Question, Answer, Comment, Subscribtion]
    can [:update, :destroy], [Question, Answer], user_id: user.id

    can [:like, :dislike, :cancel_vote], [Answer, Question] do |votable|
      !user.author_of?(votable)
    end

    can :comment, [Question, Answer]

    can :best, Answer do |answer|
      user.author_of?(answer.question)
    end

    can :destroy, ActiveStorage::Attachment do |file|
      user.author_of?(file.record)
    end

    can :destroy, Link do |link|
      user.author_of?(link.linkable)
    end

    can :me, User, user_id: user.id

    can :destroy, Subscribtion, user_id: user.id
  end
end
