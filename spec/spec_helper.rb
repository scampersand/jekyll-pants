begin
  require 'simplecov'
  SimpleCov.start
  if ENV['CI'] == 'true'
    require 'codecov'
    SimpleCov.formatter = SimpleCov::Formatter::Codecov
  end
rescue LoadError => e
  if RUBY_VERSION >= '2'
    raise e  # codecov should exist according to Gemfile
  end
end

require 'jekyll'
require File.expand_path('../lib/jekyll-pants', File.dirname(__FILE__))

Jekyll.logger.log_level = :error

RSpec.configure do |config|
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.order = 'random'

  SOURCE_DIR = File.expand_path("./fixtures", File.dirname(__FILE__))
  DEST_DIR   = File.expand_path("./dest",     File.dirname(__FILE__))

  def source_dir(*files)
    File.join(SOURCE_DIR, *files)
  end

  def dest_dir(*files)
    File.join(DEST_DIR, *files)
  end
end
