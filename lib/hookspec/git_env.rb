module HookSpec
  class GitEnv
    #an empty tree object hash
    AGAINST = '4b825dc642cb6eb9a060e54bf8d69288fbee4904'

    def initialize
    end

    def current_branch
      `git rev-parse --abbrev-ref HEAD`.chomp
    end

    def files
      `git ls-files`.chomp.split
    end

    # git diff {--cached} --name-only {--diff-filter=}
    def diff model: nil, filter: nil
      cmd = 'git diff '
      if !model.nil? && model.downcase == 'cached'
        cmd = cmd + '--cached '
      end
      cmd = cmd + '--name-only '
      if !filter.nil?
        cmd = cmd + '--diff-filter=' + filter
      end
      `#{cmd}`.chomp.split
    end

    # git confs
    def conf_of conf_name
      `git config #{conf_name}`.chomp
    end

    def white_spaces
      against = get_against

      `git diff-index --check --cached #{against} --`.chomp
    end

    def exec cmd
      `#{cmd}`.chomp
    end

    private

    def get_against
      if `git rev-parse --verify HEAD >/dev/null 2>&1`
        'HEAD'
      else
        AGAINST
      end
    end
  end
end
