source 'https://rubygems.org'

# Specify your gem's dependencies in sequel_paper_trail.gemspec
gemspec

gem 'sequel', '~> 4.0'

group :development do
  gem 'rake', '~> 10.0'
end

group :testing do
  gem 'codeclimate-test-reporter', '~> 0.4.7', require: nil
  gem 'coveralls', '~> 0.8.2', require: false
  gem 'pry', '~> 0.10.4'
  gem 'rspec', '~> 3.6.0'
  gem 'simplecov', '~> 0.10.0', platforms: :mri, require: false
  if RUBY_PLATFORM == 'java'
    gem 'jdbc-sqlite3', '~> 3.0'
  else
    gem 'sqlite3', '~> 1.0'
  end
end
