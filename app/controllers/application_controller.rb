# frozen_string_literal: true

class ApplicationController < ActionController::API
  include Pagy::Backend

  rescue_from Pagy::OverflowError, with: :redirect_to_last_page

  def encode_token(payload)
    JWT.encode(payload, 'secret')
  end

  def decode_token
    auth_header = request.headers['Authorization']

    if auth_header
      token = auth_header.split.last

      begin
        JWT.decode(token, 'secret', true, algorithm: 'HS256')
      rescue JWT::DecodeError
        nil
      end
    end
  end

  def authorized_user
    decoded_token = decode_token

    if decoded_token
      user_id = decoded_token[0]['user_id']
      @user = User.find_by(id: user_id)
    end
  end

  def authorize
    render json: { message: 'You must login' }, status: :unauthorized unless authorized_user
  end

  private

  def redirect_to_last_page(exception)
    redirect_to url_for(page: exception.pagy.last)
  end
end
