hookspec
====================

## Lastest version

v1.1.0(beta)

## About

As the name, hookspec is an git hook test tool. Write hooks like test!

## Install

    gem install hookspec

or include in Gemfile

    gem 'hookspec'

After hookspec gem is installed, you can use 'hookspec' command. Execute the command to initialize hookspec:

    bundle exec hookspec install

## Usage

New a spec file under git\_hooks/[hook\_type]/ named like _FILENAME_\_spec.rb

### Sample: Check push branch

```ruby
# assert branch is not master branch
require 'hookspec'

describe "push" do
  let (:git_env) {HookSpec::GitEnv.new}
  it 'master branch can not be pushed' do
    expect(git_env).not_to be_branch('master')
  end
end
```

### Sample: Check with rubocop

Include rubocop in your Gemfile

```ruby
describe "rubocop check" do
  let (:git_env) {HookSpec::GitEnv.new}
  it 'rubocop must pass' do
    git_env.diff(model: 'cached', filter: 'AM').each do |f| 
      if f.end_with?('.rb')
        puts `rubocop #{f}`
        expect($?).to be_nil
      end
    end
  end
end
```

## Supported hook\_type

* applypatch-msg
* pre-commit
* post-update
* prepare-commit-msg
* commit-msg
* pre-push
* pre-applypatch
* update
* post-push
* pre-rebase

## Samples

#### how to new get a git envirnment install

    git_env = HookSpec::GitEnv.new

#### how to validate branch name

    it 'master branch can not be pushed' do
      expect(git_env).not_to be_branch('master')
    end

#### how to validate include certain file or not

    it 'commit not delete certain files' do
      expect(git_env.diff(model: 'cached', filter: 'D').not_to include_file('README.md')
    end

* use git\_env.diff(model: `model_name`, filter: `filters`)
* filters: A|C|D|M|R|T|U|X|B

```ruby
# get cached file list with filter 'AM'
git_env.diff(model: 'cached', filter: 'AM')
```

#### how to get git configure

    it 'pull rebase must be setted' do
      expect(git_env.conf_of("pull.rebase")).to eql 'true'
    end

#### how to execute git commands

    git_env.exec("git status")

#### More...

_More features_ are to be continued...

## commit

fork and send pull-request
