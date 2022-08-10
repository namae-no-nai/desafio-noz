# frozen_string_literal: true

FactoryBot.define do
  factory :book do
    title { 'Romeo and Juliet' }
    description { 'A tragic romance' }
    genre { 'Romance' }
    association(:author)
    published_at { Date.today }
    publisher { 'Britanica' }
  end
end
