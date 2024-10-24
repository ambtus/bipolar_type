source 'https://rubygems.org'

gem 'rails'
gem 'haml'

group :development do
  gem 'haml-rails'
  gem 'thin'
  gem 'error_highlight', '>= 0.4.0'
end

group :production do
  gem 'unicorn'
end

group :test do
  gem 'cucumber-rails', require: false
  gem 'launchy'    # So you can do Then show me the page
end

