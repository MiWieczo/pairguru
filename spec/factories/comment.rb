FactoryBot.define do
  factory :comment do
    text { Faker::Lorem.sentence(5, true) }
    author
    movie
    created_at { Faker::Date.between(4.weeks.ago, Time.now)}
  end
end
