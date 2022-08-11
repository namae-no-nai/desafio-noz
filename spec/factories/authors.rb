# frozen_string_literal: true

FactoryBot.define do
  factory :author do
    name { Faker::Book.author }
    main_genre { Faker::Book.genre }
    age { rand(20..99) }
    association(:user)
  end
end
