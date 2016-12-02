source 'https://rubygems.org'

gem 'dotenv-rails', require: 'dotenv/rails-now'
gem 'rails', '~> 5.0.0', '>= 5.0.0.1'
gem 'puma', '~> 3.0'

group :development do
  gem 'rubocop'
  gem 'reek'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'sqlite3'
  gem 'byebug', platform: :mri
end

group :test do
  gem 'webmock'
end

group :production do
  gem 'pg'
end
