# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.3'

gem 'bcrypt', '~> 3.1', '>= 3.1.18'
gem 'bootsnap', require: false
gem 'pagy', '~> 5.10', '>= 5.10.1'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'rails', '~> 7.0.3', '>= 7.0.3.1'
gem 'rswag-api'
gem 'rswag-ui'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
gem 'jwt'

group :development, :test do
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails'
  gem 'faker', '~> 2.22'
  gem 'rspec-rails', '~> 5.0.0'
  gem 'rswag-specs'
  gem 'rubocop', require: false
end
