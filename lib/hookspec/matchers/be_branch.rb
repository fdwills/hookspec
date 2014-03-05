require 'rspec'
RSpec::Matchers.define :be_branch do |branch|
  match do |git_env|
    git_env.current_branch.eql?(branch)
  end
end
