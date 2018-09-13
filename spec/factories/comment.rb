FactoryBot.define do
  factory :comment do
    text { Faker::Lorem.sentence(5, true) }
    author
    movie
    created_at { Faker::Time.backward }
  end

  trait :this_week do
    created_at { Faker::Time.between(1.week.ago, Time.now) }
  end

  trait :older do
    created_at { Faker::Time.between(4.weeks.ago, 1.week.ago) }
  end
end
