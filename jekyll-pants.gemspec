Gem::Specification.new do |spec|
  spec.name = "jekyll-pants"
  spec.summary = "Jekyll plugin to run rubypants on generated HTML"
  spec.version = "0.1.0"
  spec.authors = ["Aron Griffis"]
  spec.email = "aron@scampersand.com"
  spec.homepage = "https://github.com/scampersand/jekyll-pants"
  spec.licenses = ["MIT"]

  spec.files = `git ls-files -z`.split("\x0")
  spec.executables = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "rubypants"

  spec.add_development_dependency "jekyll", ">= 2.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
