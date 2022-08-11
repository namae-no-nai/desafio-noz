# frozen_string_literal: true

module Api
  class UsersController < ApplicationController
    def create
      @user = User.new(user_params)
      if @user.save
        token = encode_token({ user_id: @user.id })

        render json: { token: token }, status: :created
      else
        render json: { error: 'username or password invalid' }, status: :unprocessable_entity
      end
    end

    def login
      @user = User.find_by(username: user_params[:username])

      if @user && @user.authenticate(user_params[:password])
        token = encode_token({ user_id: @user.id })

        render json: { token: token }, status: :ok
      else
        render json: { error: 'username or password invalid' }, status: :unprocessable_entity
      end
    end

    private

    def user_params
      params.permit(:username, :password)
    end
  end
end
