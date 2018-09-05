FactoryBot.define do
  factory :comment do
    name "gentlelady"
    content {Faker::Lorem.word}
    article_id nil
  end
end