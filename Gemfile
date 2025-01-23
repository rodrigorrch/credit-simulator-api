source "https://rubygems.org"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 8.0.1"
gem "pg", "~> 1.1"
gem "puma", ">= 5.0"
# gem "jbuilder"
gem "rack-cors", "~> 2.0"

gem "tzinfo-data", platforms: %i[ windows jruby ]

# Use the database-backed adapters for Rails.cache, Active Job, and Action Cable
# gem "solid_cache"
# gem "solid_queue"
# gem "solid_cable"

gem "bcrypt", "~> 3.1.7"

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Deploy this application anywhere as a Docker container [https://kamal-deploy.org]
gem "kamal", require: false

# Add HTTP asset caching/compression and X-Sendfile acceleration to Puma [https://github.com/basecamp/thruster/]
gem "thruster", require: false
gem "money-rails", "~> 1.15"
gem "kaminari", "~> 1.2"
gem "swagger-docs", "~> 0.2.9"

group :development, :test do
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
  gem "brakeman", require: false
  gem "rubocop-rails-omakase", require: false
  gem "rspec-rails", "~> 7.1"
  gem "factory_bot_rails", "~> 6.4"
  gem "faker", "~> 3.5"
  gem "rubocop", "~> 1.71"
  gem "rubocop-rails", "~> 2.29"
  gem "rubocop-rspec", "~> 3.4"
  gem "pry-rails"
end

group :development do
  gem "spring", require: false
end



