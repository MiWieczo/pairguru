FactoryBot.define do
  factory :user, aliases: [:author] do
    name { Faker::FunnyName.name }
    email { Faker::Internet.email }
    password { Faker::Lorem.characters(8) }
  end
end
