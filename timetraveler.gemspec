
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "time_traveler/version"

Gem::Specification.new do |spec|
  spec.name          = "timetraveler"
  spec.version       = TimeTraveler::VERSION
  spec.authors       = ["Jan Lindblom"]
  spec.email         = ["janlindblom@fastmail.fm"]

  spec.summary       = %q{Find timezone based on geographical location, offline.}
  spec.homepage      = "https://gitlab.com/robotika.ax/ruby-timetraveler"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.4"
  spec.add_development_dependency "rake", "~> 13"
  spec.add_development_dependency "rspec", "~> 3"
  spec.add_development_dependency "pry", "~> 0.14"
  spec.add_development_dependency "rubyzip", "~> 2.3"
  spec.add_development_dependency "dotenv", "~> 2.7"
  spec.add_development_dependency "yard", "~> 0.9"
  spec.add_development_dependency "simplecov", "~> 0.21"
  spec.add_development_dependency "rspec_junit_formatter", "~> 0.6"
  spec.add_development_dependency "simplecov-cobertura", "~> 2.1"
  spec.add_development_dependency "rubocop", "~> 1"
  spec.add_runtime_dependency "quadtree", "~> 1.0.9"
  spec.add_runtime_dependency "tzinfo", "~> 2.0"
  spec.add_runtime_dependency "tzinfo-data", "~> 1"
end
