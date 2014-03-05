hookspec
====================

## Lastest version

v1.0.0(beta)

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

    # assert branch is not master branch
    require 'hookspec'

    describe "push" do
      let (:git_env) {HookSpec::GitEnv.new}
      it 'master branch can not be pushed' do
        expect(git_env).not_to be_branch('master')
      end
    end

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

    it 'show not include certain files' do
      expect(git_env.diffs_of_local[:D]).not_to include_file('README.md')
    end

Provide three diff type of diffs:

* git\_env.diffs\_of\_local: unstaged files hashed by status types(A|C|D|M|R|T|U|X|B)
* git\_env.diffs\_of\_cached: cached files hashed by status types(A|C|D|M|R|T|U|X|B)
* git\_env.diffs\_of\_commited: last commited files hashed by status types(A|C|D|M|R|T|U|X|B)

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
