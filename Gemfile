source 'https://rubygems.org'

gem 'pg', '~> 1.1'
gem 'puma', '>= 5.0'
gem 'rack-cors', '~> 2.0'
gem 'rails', '~> 8.0.1'

gem 'tzinfo-data', platforms: [:windows, :jruby]

# Use the database-backed adapters for Rails.cache, Active Job, and Action Cable
# gem "solid_cache"
# gem "solid_queue"
# gem "solid_cable"

gem 'bcrypt', '~> 3.1.7'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

# Deploy this application anywhere as a Docker container [https://kamal-deploy.org]
gem 'kamal', require: false

# Add HTTP asset caching/compression and X-Sendfile acceleration to Puma [https://github.com/basecamp/thruster/]
gem 'bunny'
gem 'dry-types'
gem 'dry-validation'
gem 'kaminari', '~> 1.2'
gem 'money-rails', '~> 1.15'
gem 'rswag'
gem 'rswag-api'
gem 'rswag-ui'
gem 'sidekiq'
gem 'thruster', require: false
gem 'zeitwerk'

group :development, :test do
  gem 'brakeman', require: false
  gem 'database_cleaner'
  gem 'debug', platforms: [:mri, :windows], require: 'debug/prelude'
  gem 'factory_bot_rails', '~> 6.4'
  gem 'faker', '~> 3.5'
  gem 'pry'
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'rspec-rails', '~> 7.1'
  gem 'rswag-specs'
  gem 'rubocop', '~> 1.72'
  gem 'rubocop-rails', '~> 2.29'
  gem 'rubocop-rails-omakase', require: false
  gem 'rubocop-rspec', '~> 3.4'
end

group :development do
  gem 'spring', require: false
end

gem 'shoulda-matchers', '~> 6.4', group: :test
