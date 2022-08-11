# frozen_string_literal: true

class Book < ApplicationRecord
  include ActiveModel::Serializers::JSON

  belongs_to :author
end
