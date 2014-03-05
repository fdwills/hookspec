module HookSpec
  class GitEnv
    #an empty tree object hash
    AGAINST = '4b825dc642cb6eb9a060e54bf8d69288fbee4904'

    def initialize
      @current_branch    = nil
      @cached_diffs_info = nil
      @commit_diffs_info = nil
      @local_diffs_info  = nil
      @all_files         = nil
    end

    def current_branch
      return @current_branch unless @current_branch.nil?
      @current_branch = `git rev-parse --abbrev-ref HEAD`.chomp!
    end

    def files
      return @all_files unless @all_files.nil?
      @all_files = `git ls-files`.chomp!.split
    end

    # diff files with status
    def diffs_of_commit
      return @commit_diffs_info unless @commit_diffs_info.nil?

      against = get_against

      diff = `git diff HEAD^ HEAD --name-status`.chomp!
      @commit_diffs_info = classify(diff)
    end

    def diffs_of_cached
      return @cached_diffs_info unless @cached_diffs_info.nil?

      diff = `git diff --cached --name-status`.chomp!
      @cached_diffs_info = classify(diff)
    end

    def diffs_of_local
      return @local_diffs_info unless @local_diffs_info.nil?

      diff = `git diff --name-status`.chomp!
      @local_diffs_info = classify(diff)
    end


    # git confs
    def conf_of conf_name
      return `git config #{conf_name}`.chomp!
    end

    def white_spaces
      against = get_against

      return `git diff-index --check --cached #{against} --`.chomp!
    end

    def exec cmd
      return `#{cmd}`.chomp!
    end

    private

    def classify diffs
      classified = {}
      diffs.each_line(separator = $/) do |line|
        Hash[*line.split].each_pair do |key, value|
          if classified[key.to_sym].nil?
            classified[key.to_sym] = [value]
          else
            classified[key.to_sym] << value
          end
        end
      end
      return classified
    end

    def get_against
      if `git rev-parse --verify HEAD >/dev/null 2>&1`
        return 'HEAD'
      else
        return AGAINST
      end
    end
  end
end
