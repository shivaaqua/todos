source 'http://rubygems.org'

gem 'rails', '3.2.3'
gem 'unicorn'
gem 'pg'

gem 'jquery-rails'
gem 'bcrypt-ruby', '~> 3.0.0'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'therubyracer', :platform => :ruby
  gem 'uglifier', '>= 1.0.3'
end

group :development do
  gem 'annotate'
  gem 'capistrano'
  gem 'rails_best_practices'
  gem 'railroad'        
end

group :development, :test do
  gem 'factory_girl_rails'
  gem 'database_cleaner'
  gem 'cucumber-rails', :require => false
  gem "rspec-rails", "~> 2.0"
  gem 'faker'
  gem 'capybara'
  gem "guid", "~> 0.1.1"
end

group :test do
  gem 'simplecov', :require => false
  gem "shoulda-matchers"
end



# To use Jbuilder templates for JSON
# gem 'jbuilder'


