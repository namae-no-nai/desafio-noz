# frozen_string_literal: true

class CreateAuthors < ActiveRecord::Migration[7.0]
  def change
    create_table :authors do |t|
      t.string :name
      t.string :main_genre
      t.integer :age

      t.timestamps
    end
  end
end
