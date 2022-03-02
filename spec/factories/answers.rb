FactoryBot.define do
  factory :answer do
    body { "MyText" }
    question_id { "" }

    trait :invalid do
      body { nil }
      question_id { nil }
    end
  end
end
