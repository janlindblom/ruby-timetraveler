
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "timezone_calculator/version"

Gem::Specification.new do |spec|
  spec.name          = "timezone_calculator"
  spec.version       = TimezoneCalculator::VERSION
  spec.authors       = ["Jan Lindblom"]
  spec.email         = ["jan.lindblom@mittmedia.se"]

  spec.summary       = %q{}
  spec.description   = %q{Find timezone based on geographical location offline.}
  spec.homepage      = "https://bitbucket.org/janlindblom/ruby-timezone-calculator"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
