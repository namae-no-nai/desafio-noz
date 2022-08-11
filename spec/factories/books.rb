# frozen_string_literal: true

FactoryBot.define do
  factory :book do
    title { Faker::Book.title }
    description { Faker::Lorem.sentence(word_count: 10) }
    genre { Faker::Book.genre }
    association(:author)
    published_at { Date.today - rand(1000..3000).days }
    publisher { Faker::Book.publisher }
  end
end
