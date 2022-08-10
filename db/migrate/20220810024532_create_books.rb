# frozen_string_literal: true

class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books do |t|
      t.string :title
      t.string :description
      t.string :genre
      t.references :author, null: false, foreign_key: true
      t.date :published_at
      t.string :publisher

      t.timestamps
    end
  end
end
