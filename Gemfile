source "https://rubygems.org"
gemspec

if ENV["JEKYLL_VERSION"]
  gem "jekyll", "~> #{ENV["JEKYLL_VERSION"]}"
end

if ENV["CODECOV"] != "false"
  gem 'codecov', :require => false, :group => :test
end
