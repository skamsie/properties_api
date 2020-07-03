source "https://rubygems.org"

ruby "2.5.6"

gem "rails", "~> 5.2.4"
gem "pg", ">= 0.18", "< 2.0"
gem "bootsnap", ">= 1.1.0", require: false
gem "active_interaction", "~> 3.8"

group :development, :test do
  %w[rspec-core rspec-expectations rspec-mocks rspec-rails rspec-support].each do |lib|
    gem lib, :git => "https://github.com/rspec/#{lib}.git", :branch => "master"
  end

  gem "pry-rails"
  gem "factory_bot"
  gem "pry-byebug"
  gem "rack-test", require: "rack/test"
  gem "rubocop"
  gem "database_cleaner"
end

group :development do
  gem "listen", ">= 3.0.5", "< 3.2"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
