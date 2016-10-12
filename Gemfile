source "https://rubygems.org"
gemspec

if ENV["JEKYLL_VERSION"]
  gem "jekyll", "~> #{ENV["JEKYLL_VERSION"]}"
end

if RUBY_VERSION >= "2"
  gem "json"
end

gem 'codecov', :require => false, :group => :test
