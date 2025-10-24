# frozen_string_literal: true

require_relative "lib/llm_rescuer/version"

Gem::Specification.new do |spec|
  spec.name = "llm_rescuer"
  spec.version = LlmRescuer::VERSION
  spec.authors = ["Paul Chobert"]
  spec.email = ["paul@chobert.fr"]

  spec.summary = "Fix the billion-dollar mistake by spending billions on LLM tokens! 🤖💰"
  spec.description = "LLM Rescuer uses artificial intelligence to guess what you probably meant when you called a method on nil. Instead of crashing with NoMethodError, it asks GPT to analyze your code and hallucinate a reasonable response. Because clearly, the best way to solve Tony Hoare's billion-dollar mistake is to throw AI at it until it works. What could possibly go wrong? 🎭"
  spec.homepage = "https://github.com/barodeur/llm_rescuer"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.1.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/paul/llm_rescuer"
  spec.metadata["changelog_uri"] = "https://github.com/paul/llm_rescuer/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.each_line("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  spec.add_dependency "binding_of_caller", "~> 1.0.1"
  spec.add_dependency "ruby_llm", "~> 1.8.2"
  spec.add_dependency "ruby_llm-schema", "~> 0.2.1"
end
