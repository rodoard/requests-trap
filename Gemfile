source 'https://rubygems.org'

ruby '2.1.1'

gem 'rails', '4.1.5'

gem 'pg'
gem 'erubis'
gem 'coffee-rails'
gem 'jquery-rails'
gem 'uglifier'

# >>> for live updates
gem 'websocket-rails'
gem 'thin'
# <<< for live updates

group :production do
  gem 'rails_12factor'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'shoulda-matchers'
  gem 'factory_girl_rails'
  gem 'database_cleaner'
  gem 'rspec-html-matchers'
end
