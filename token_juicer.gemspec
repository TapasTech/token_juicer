require_relative 'lib/token_juicer/version'

Gem::Specification.new do |spec|
  spec.name          = "token_juicer"
  spec.version       = TokenJuicer::VERSION
  spec.authors       = ["anoymouscoder"]
  spec.email         = ["809532742@qq.com"]

  spec.summary       = "token 榨汁机"
  spec.description   = "token 榨汁机"
  spec.homepage      = "http://www.cbndata.com"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")
  spec.add_runtime_dependency 'jwt'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
