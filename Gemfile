source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rack-cors', :require => 'rack/cors'
gem 'rails', '~> 5.2.1'
gem 'pg', '~> 1.1'
gem 'puma', '~> 3.7'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 5.0'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.8'
gem 'high_voltage', '~> 3.1.0'

gem 'cocoon'
gem 'bcrypt', git: 'https://github.com/codahale/bcrypt-ruby.git', :require => 'bcrypt'
gem 'devise'
gem 'jquery-rails'
gem 'pundit'

gem "aws-sdk-s3", require: false
gem 'devise-i18n'

gem 'gon'

gem 'bootstrap'

gem 'geocoder'

gem 'rubyzip'

gem 'bootstrap4-kaminari-views'
gem 'kaminari'

gem 'wicked'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'capybara', '~> 3.11'
  gem 'selenium-webdriver'
end

group :development do
  gem 'web-console', '>= 3.3.0'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
