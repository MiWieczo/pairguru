FactoryBot.define do
  factory :comment do
    text { Faker::Lorem.sentence(5, true) }
    author
    movie
    created_at { Faker::Date.backward }
  end
  
  trait :this_week do
    created_at { Faker::Date.between(1.weeks.ago, Time.now) }
  end
  
  trait :older do
    created_at { Faker::Date.between(4.weeks.ago, 1.week.ago) }
  end
end
