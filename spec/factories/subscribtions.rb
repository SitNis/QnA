FactoryBot.define do
  factory :subscribtion do
    association :question
    association :user
  end
end
