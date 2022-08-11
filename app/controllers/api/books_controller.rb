# frozen_string_literal: true

module Api
  class BooksController < ApplicationController
    before_action :set_book, only: %i[show update destroy]

    def index
      @books = Book.all
      @books = ::QueryFilter.call(@books, filter_params) if filter_params.present?

      @pagy, @books = pagy(@books, items: 5)
      render json: { count: @pagy.count, page: @pagy.page, pages: @pagy.pages, books: @books }
    end

    def show
      render json: @book
    end

    def create
      @book = Book.new(book_params)

      if @book.save
        render json: @book, status: :created, location: api_book_url(@book)
      else
        render json: @book.errors, status: :unprocessable_entity
      end
    end

    def update
      if @book.update(book_params)
        render json: @book
      else
        render json: @book.errors, status: :unprocessable_entity
      end
    end

    def destroy
      @book.destroy
    end

    private

    def set_book
      @book = Book.find(params[:id])
    end

    def book_params
      params.require(:book).permit(:title, :description, :genre, :author_id, :published_at, :publisher)
    end

    def filter_params
      params.permit(:title, :description, :genre, :published_at)
    end
  end
end
