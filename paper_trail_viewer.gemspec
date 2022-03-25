lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require_relative 'lib/paper_trail_viewer/version'

Gem::Specification.new do |spec|
  spec.name          = 'paper_trail_viewer'
  spec.version       = PaperTrailViewer::VERSION
  spec.authors       = ['Janosch Müller', 'Igal Koshevoy']
  spec.summary       = 'A user interface for `paper_trail` versioning data in Ruby on Rails applications.'
  spec.description   = 'Browse, view and revert changes to records when using Ruby on Rails and the `paper_trail` gem.'
  spec.homepage      = 'https://github.com/jaynetics/paper_trail_viewer'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0") + %w[/javascript/compiled.js]
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'kaminari'
  spec.add_dependency 'paper_trail', ['>= 11.1']
  spec.add_dependency 'rails', ['>= 6.0', '< 8.0']

  spec.add_development_dependency 'appraisal', '~> 1.0'
  spec.add_development_dependency 'capybara', '~> 3.0'
  spec.add_development_dependency 'factory_bot_rails', '~> 6.0'
  spec.add_development_dependency 'puma', '~> 5.0'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec-rails', '~> 5.0'
  spec.add_development_dependency 'sqlite3', '>= 1.3.6'
  spec.add_development_dependency 'webdrivers', '~> 5.0'
end
