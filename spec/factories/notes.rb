# Set some faked notes
FactoryBot.define do
  factory :note do
    markdown { Faker::Markdown.random }
  end
end