# frozen_string_literal: true

module Api
  class AuthorsController < ApplicationController
    before_action :set_author, only: %i[show update destroy]

    def index
      @authors = Author.all
      @authors = ::QueryFilter.call(@authors, filter_params) if filter_params.present?

      @pagy, @authors = pagy(@authors, items: 5)
      @authors = @authors.map { |author| author.serializable_hash(include: :books) }

      render json: { count: @pagy.count, page: @pagy.page, pages: @pagy.pages, authors: @authors }
    end

    def show
      render json: @author
    end

    def create
      @author = Author.new(author_params)

      if @author.save
        render json: @author, status: :created, location: api_author_url(@author)
      else
        render json: @author.errors, status: :unprocessable_entity
      end
    end

    def update
      if @author.update(author_params)
        render json: @author
      else
        render json: @author.errors, status: :unprocessable_entity
      end
    end

    def destroy
      @author.destroy
    end

    private

    def set_author
      @author = Author.find(params[:id])
    end

    def author_params
      params.require(:author).permit(:name, :main_genre, :age)
    end

    def filter_params
      params.permit(:name, :main_genre, :age)
    end
  end
end
