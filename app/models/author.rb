# frozen_string_literal: true

class Author < ApplicationRecord
  include ActiveModel::Serializers::JSON

  validates :name, :main_genre, :age, presence: true
  validates :age, numericality: { only_integer: true }

  has_many :books, dependent: :destroy
end
