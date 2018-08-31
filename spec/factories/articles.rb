FactoryBot.define do
  factory :article do
    title {Faker::Lorem.word}
    post {Faker::Lorem.word}
    user_id nil
  end
end