FactoryBot.define do
  factory :comment do
    name "gentlelady"
    content {Faker::Lorem.word}
  end
end