source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.3', '>= 6.0.3.4'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 4.1'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Nokogiri (鋸) is an HTML, XML, SAX, and Reader parser. Among Nokogiri's many features is the ability to search documents via XPath or CSS3 selectors.
gem 'nokogiri', '~> 1.8.5'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors'

# Easy way to add scopes to your models.
gem 'active_record_filterable'
# Creates representations of your model data in a simple and clean way
gem 'as_json_representations'
# Kaminari is a Scope & Engine based, clean, powerful, agnostic, customizable and sophisticated
# paginator for Rails 4+
gem 'kaminari'
# Pundit provides a set of helpers which guide you in leveraging regular Ruby classes and object oriented design patterns to build a simple, robust and scalable authorization system.
gem 'pundit'
# Dotenv is used for get environment variables from file .env
gem 'dotenv-rails'
# RuboCop is a Ruby static code analyzer (a.k.a. linter) and code formatter.
gem 'rubocop', require: false
# PgSearch builds named scopes that take advantage of PostgreSQL's full text search.
gem 'pg_search'
# The Mechanize library is used for automating interaction with websites.
gem 'mechanize'
# Makes http fun again! Ain't no party like a httparty, because a httparty don't stop.
gem 'httparty'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  # Use Pry as your rails console
  gem 'pry-rails'
  # factory_bot_rails provides integration between factory_bot and rails 4.2 or newer
  gem 'factory_bot_rails'
  # Faker is used to easily generate fake data: names, addresses, phone numbers, etc.
  gem 'faker'
  # A gem providing "time travel" and "time freezing" capabilities
  gem 'timecop'
end

group :development do
  # Add a comment summarizing the current schema to the top or bottom of each of your...
  gem 'annotate'
  gem 'bullet'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more:
  # https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

group :test do
  gem 'database_cleaner'
  gem 'rspec-rails'
  # Provides RSpec- and Minitest-compatible one-liners to test common Rails functionality that.
  gem 'shoulda-matchers'
  # Code coverage for Ruby with a powerful configuration library and automatic merging of coverage
  # across test suites
  gem 'simplecov'
  # Rubocop rspec
  gem 'rubocop-rspec', require: false
end

