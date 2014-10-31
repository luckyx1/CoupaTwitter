source 'http://rubygems.org'
ruby '2.1.2'

gem 'rails', '3.2.19'

gem 'mysql2', '~> 0.2.11'



# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'jquery-turbolinks'
#for protecting people's privacy, generates hash
gem "bcrypt"

gem 'pronto-rubocop'
gem  'rubocop'


group :development do 
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'meta_request'
  gem 'simple_form'
end

group :test do
  gem 'database_cleaner' # to clear Cucumber's test database between runs, only needed in testing
  gem 'selenium-webdriver' #for js testing
  gem 'cucumber-rails', :require => false
  gem 'cucumber-rails-training-wheels'
  gem 'factory_girl_rails'
  gem 'capybara'         # lets Cucumber pretend to be a web browser
  gem 'rspec-rails'
end

group :assets do
  # Use Uglifier as compressor for JavaScript assets
  gem 'uglifier', '>= 1.3.0'
  # Use CoffeeScript for .js.coffee assets and views
end 

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger (ruby-debug for Ruby 1.8.7+, ruby-debug19 for Ruby 1.9.2+)
# gem 'ruby-debug'
# gem 'ruby-debug19', :require => 'ruby-debug'

# Bundle the extra gems:
# gem 'bj'
# gem 'nokogiri'
# gem 'sqlite3-ruby', :require => 'sqlite3'
# gem 'aws-s3', :require => 'aws/s3'

# Bundle gems for the local environment. Make sure to
# put test-only gems in this group so their generators
# and rake tasks are available in development mode:
# group :development, :test do
#   gem 'webrat'
# end
