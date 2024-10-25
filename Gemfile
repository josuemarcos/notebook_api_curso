source "https://rubygems.org"


# A library for generating fake data such as names, addresses, and phone numbers.
gem "faker"
# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.2.1"

# Repository for collecting Locale data for Ruby on Rails I18n as well as other interesting, Rails related I18n stuff
gem "rails-i18n", "~> 7.0.0"

# Use sqlite3 as the database for Active Record
# gem "sqlite3", ">= 1.4"

# Use PostgreSQL as the database for Active Record
gem "pg", "~> 1.5"


gem "ostruct", "~> 0.1.0"

# ActiveModel::Serializers allows you to generate your JSON in an object-oriented and convention-driven manner.
gem "active_model_serializers", "~> 0.10.2"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", ">= 5.0"
# Build JSON APIs with ease [https://github.com/rails/jbuilder]
# gem "jbuilder"
# Use Redis adapter to run Action Cable in production
# gem "redis", ">= 4.0.1"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ windows jruby ]



 # Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
 # gem "image_processing", "~> 1.2"

 # Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin Ajax possible
 gem "rack-cors"




group :development, :test do
  # Reduces boot times through caching; required in config/boot.rb
  gem "bootsnap", ">= 1.4.4", require: false
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"

  # Static analysis for security vulnerabilities [https://brakemanscanner.org/]
  gem "brakeman", require: false

  # Omakase Ruby styling [https://github.com/rails/rubocop-rails-omakase/]
  gem "rubocop-rails-omakase", require: false

  # Rails >= 3 pry initializer
  gem "pry-rails"
end
