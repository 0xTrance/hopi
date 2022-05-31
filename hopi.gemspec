# frozen_string_literal: true

require_relative "lib/hopi/version"

Gem::Specification.new do |spec|
  spec.name = "hopi"
  spec.version = Hopi::VERSION
  spec.authors = ["Trance"]
  spec.email = ["oxtrance@protonmail.com"]

  spec.summary = "Anonymously make HTTP requests through the tor network using Socks5 Proxy"
  spec.homepage = "https://github.com/0xTrance/hopi"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/0xTrance/hopi"
  spec.metadata["changelog_uri"] = "https://github.com/0xTrance/hopi/blob/main/CHANGELOG.md"

  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
