# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "paper_trail_manager"
  spec.version       = "0.6.0"
  spec.authors       = ["Igal Koshevoy", "Reid Beels"]
  spec.authors       = ["mail@reidbeels.com"]
  spec.summary       = "A user interface for `paper_trail` versioning data in Ruby on Rails 3 applications."
  spec.description   = "Browse, subscribe, view and revert changes to records when using Ruby on Rails 3 and the `paper_trail` gem."
  spec.homepage      = "https://github.com/fusion94/paper_trail_manager"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "rails", [">= 3.0", "< 5.0"]
  spec.add_dependency "paper_trail", [">= 3.0", "< 5.0"]

  spec.add_development_dependency "rake", "~> 10.4"
  spec.add_development_dependency "sqlite3", "~> 1.3"
  spec.add_development_dependency "factory_girl_rails", "~> 4.0"
  spec.add_development_dependency "rspec-rails", "~> 3.0"
  spec.add_development_dependency "rspec-activemodel-mocks", "~> 1.0"
  spec.add_development_dependency "rspec-its", "~> 1.0"
  spec.add_development_dependency "appraisal", "~> 1.0"
end

