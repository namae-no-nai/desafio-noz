# frozen_string_literal: true

if Author.count.zero?
  10.times do
    author = Author.create(
      name: Faker::Book.author,
      age: rand(20..99),
      main_genre: Faker::Book.genre
    )

    3.times do
      author.books.create(
        title: Faker::Book.title,
        description: Faker::Lorem.sentence(word_count: 10),
        genre: Faker::Book.genre,
        publisher: Faker::Book.publisher,
        published_at: Date.today - rand(1000..3000).days
      )
    end
  end
end
