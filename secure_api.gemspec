$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "secure_api/version"

Gem::Specification.new do |spec|
  spec.name          = "secure_api"
  spec.version       = SecureApi::VERSION
  spec.authors       = ["david metta"]
  spec.email         = ["davideliemetta@gmail.com"]
  spec.summary       = "API Auth framework for Rails"
  spec.description   = "Tiny JWT-based Authenticaton framework for RoR API's"
  spec.homepage      = "https://github.com/davidmetta/secure_api"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["allowed_push_host"] = "https://rubygems.org"
  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/davidmetta/secure_api.git"
  # spec.metadata["changelog_uri"] = ""

  # spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  # spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) { `git ls-files -z`.split("\x0") }
  # spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.files = `git ls-files -z`.split("\x0").reject { |f| f.start_with?('test/') }
  spect.test_files = `git ls-files -z`.split("\x0").select { |f| f.start_with?('test/') }
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'jwt', '~> 2.2.2'
  spec.add_dependency "rails", "~> 6.0.3", ">= 6.0.3.4"

  spec.add_development_dependency "pg", '~> 1.2.3'
end
