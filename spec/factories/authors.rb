# frozen_string_literal: true

FactoryBot.define do
  factory :author do
    name { 'Shakespeare' }
    main_genre { 'Romance' }
    age { 34 }
  end
end
