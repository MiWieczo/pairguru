FactoryBot.define do
  factory :user, aliases: [:author] do
    name { Faker::FunnyName.name }
    email { Faker::Internet.email }
    password { Faker::Lorem.characters(8) }
  end

  trait :with_comments do
    after(:create) do |user|
      create_list :comment, rand(5..20), :this_week, author: user
    end
  end
end
