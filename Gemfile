source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


gem 'rails', '~> 5.1.1'
gem 'mysql2', '>= 0.3.18', '< 0.5'
gem 'puma', '~> 3.7'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'webpacker'

gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'

gem 'devise', '~> 4.3'
gem 'state_machines-activerecord', '~> 0.5.0'

gem 'kaminari', '~> 1.0', '>= 1.0.1'
gem 'jquery-rails'
gem 'font-awesome-sass', '~> 4.7'
gem 'bootstrap-sass', '~> 3.3', '>= 3.3.7'
gem 'cocoon', '~> 1.2'
gem 'ransack', '~> 1.8', '>= 1.8.2'
gem 'paranoia', '~> 2.3', '>= 2.3.1'
gem 'carrierwave', '~> 0.11.2'
gem 'fog-google', '~> 0.4.0'
gem 'google-api-client', '~> 0.9.15'
gem 'mime-types', '~> 3.1'
gem 'elasticsearch', git: 'git://github.com/elasticsearch/elasticsearch-ruby.git'
gem 'deep_cloneable', '~> 2.2', '>= 2.2.2'

gem 'redis', '~> 3.3', '>= 3.3.3'

gem 'unicorn', '~> 5.3'

gem 'active_model_serializers', '~> 0.10.0'
gem 'oj'
gem 'rpush', '~> 2.7.0'
gem 'net-http-persistent', '2.9.4'

gem 'roo', '~> 2.7.0'

gem 'sidekiq', '~> 4.2.7'
gem 'sidekiq-batch', '~>0.1.2'
gem 'sidekiq-cron', '~> 0.6.3'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'capybara', '~> 2.13.0'
  gem 'selenium-webdriver'
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'spring-commands-rspec'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'

  gem 'rspec-rails', '~> 3.6'

  gem 'capistrano', '~> 3.8', '>= 3.8.1'
  gem 'capistrano-rvm', '~> 0.1.2'
  gem 'capistrano-bundler', '~> 1.2'
  gem 'capistrano-sidekiq', '~> 0.10.0'
  gem 'capistrano-rails', '~> 1.2', '>= 1.2.3'
  gem 'capistrano3-unicorn', '~> 0.2.1'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
