# frozen_string_literal: true

class Author < ApplicationRecord
  validates :name, :main_genre, :age, presence: true
  validates :age, numericality: { only_integer: true }

  has_many :books, dependent: :destroy
end
