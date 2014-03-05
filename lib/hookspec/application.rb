module HookSpec
  class Application < Rake::Application

    def initialize
      super
      @branch = `git rev-parse --abbrev-ref HEAD`.chomp!
      @diffs_info = {}
      @all_files = []
    end

    def run
      Rake.application = self
      super
    end

    def load_rakefile
      load File.expand_path(File.join(File.dirname(__FILE__),'tasks/install.rake'))
    end

  end
end
