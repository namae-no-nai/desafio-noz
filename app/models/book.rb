# frozen_string_literal: true

class Book < ApplicationRecord
  include ActiveModel::Serializers::JSON

  validates :title, :description, :genre, :published_at, :publisher, presence: true
  validates :published_at, format: { with: /\A[0-9]{4}-[0-9]{2}-[0-9]{2}\z/ }

  belongs_to :author
end
