FactoryBot.define do
  factory :vote do
    value { 1 }
    user
    association :votable, factory: :question
  end
end
