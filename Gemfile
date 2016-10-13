source "https://rubygems.org"
gemspec

if ENV["JEKYLL_VERSION"]
  gem "jekyll", "~> #{ENV["JEKYLL_VERSION"]}"
end

if RUBY_VERSION >= "2"
  gem "json"

  # This requires json, so it doesn't install on Ruby 1.9.3
  # https://travis-ci.org/scampersand/jekyll-pants/builds/167216488
  gem 'codecov', :require => false, :group => :test
end
