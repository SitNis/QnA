FactoryBot.define do
  factory :answer do
    body { "MyAnswer" }
    question
    user

    trait :invalid do
      body { nil }
      question_id { nil }
    end
  end
end
