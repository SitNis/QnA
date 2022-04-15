FactoryBot.define do
  factory :comment do
    body { 'text1' }
    user
    association :commentable, factory: :question
  end
end
