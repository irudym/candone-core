# Set some faked tasks
FactoryBot.define do
  factory :task do
    title { Faker::BackToTheFuture.quote }
    description { Faker::Lorem.paragraph }
    urgency { 0 }
  end
end