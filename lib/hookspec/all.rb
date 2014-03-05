require 'rake'

Rake.application.options.trace = true

require 'hookspec/version'
require 'hookspec/application'
require 'hookspec/matchers'
require 'hookspec/git_env'

module HookSpec
end
