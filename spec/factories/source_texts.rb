FactoryBot.define do
  factory :source_text do
    trait :with_text do
      text { "Hello world." }
    end
  end
end
