# -*- encoding: utf-8 -*-
lib = File.expand_path(File.join(File.dirname(__FILE__),'lib/'))
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'hookspec/version'

Gem::Specification.new do |s|
  s.name        = 'hookspec'
  s.version     = HookSpec::VERSION
  s.date        = '2014-03-06'
  s.summary     = "git hooks by spec"
  s.description = "write git hooks like spec"
  s.authors     = ["wills"]
  s.email       = 'weirenzhong@gmail.com'
  s.files       = `git ls-files`.split($/)
  s.homepage    = 'https://github.com/fdwills/hookspec'
  s.license     = 'MIT'
  s.executables << 'hookspec'

  s.add_runtime_dependency "rspec", ">= 2.13.0"
  s.add_development_dependency "bundler", "~> 1.3"
  s.add_development_dependency "rake"
end
