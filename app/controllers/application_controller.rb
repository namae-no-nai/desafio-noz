# frozen_string_literal: true

class ApplicationController < ActionController::API
  include Pagy::Backend

  rescue_from Pagy::OverflowError, with: :redirect_to_last_page

  private

  def redirect_to_last_page(exception)
    redirect_to url_for(page: exception.pagy.last)
  end
end
