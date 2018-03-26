
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "time_traveler/version"

Gem::Specification.new do |spec|
  spec.name          = "timetraveler"
  spec.version       = TimeTraveler::VERSION
  spec.authors       = ["Jan Lindblom"]
  spec.email         = ["jan.lindblom@mittmedia.se"]

  spec.summary       = %q{Find timezone based on geographical location, offline.}
  spec.homepage      = "https://bitbucket.org/janlindblom/ruby-timetraveler"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry", "~> 0.11"
  spec.add_development_dependency "rubyzip", "~> 1.2"
  spec.add_runtime_dependency "quadtree", "~> 1.0"
  spec.add_runtime_dependency "tzinfo"
  spec.add_runtime_dependency "tzinfo-data"
end
