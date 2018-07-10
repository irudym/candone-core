# Set some faked projects
FactoryBot.define do
  factory :project do
    title { Faker::BackToTheFuture.quote }
    description { Faker::Lorem.paragraph }
  end
end