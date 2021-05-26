require_relative 'lib/rhelm/version'

Gem::Specification.new do |spec|
  spec.name          = "rhelm"
  spec.version       = Rhelm::VERSION
  spec.authors       = ["Jack Newton", "Nick Marden"]
  spec.email         = ["jnewton@avvo.com", "nick@rrsoft.co"]
  spec.licenses      = ["MIT"]

  spec.summary       = "A wrapper around helm3, including error detection and output parsing callback support"
  spec.description   = "Invoke Helm 3.x commands from Ruby with easy result handling"
  spec.homepage      = "https://github.com/internetbrands/rhelm"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.5")

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  #spec.metadata["changelog_uri"] = ""

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
