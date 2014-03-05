require 'erb'
require 'pathname'

desc 'Install hookspec...'
task :install do

  unless File.exist?('.git') && File.directory?('.git')
    puts '''
Current dirctory is not in a git repo Or
Current dirctory is not git repo root dirctory!
'''
    exit 1
  end

  hooks = %w{
    applypatch-msg
    pre-applypatch
    prepare-commit-msg
    commit-msg
    pre-commit
    update
    post-update
    pre-rebase
    pre-push
    post-push
  }

  hook_dir = Pathname.new('git_hooks')
  hook_bk_dir = Pathname.new('.git/hooks/bak')

  mkdir_p hook_dir
  mkdir_p hook_bk_dir

  hooks.each do |hook|
    # copy hook.sh
    mv(".git/hooks/#{hook}", ".git/hooks/#{hook}.bk")
    sh_template = File.read (File.expand_path("../../templates/" + hook + ".sh", __FILE__) )
    File.open(".git/hooks/#{hook}", 'w+') do |f|
      f.write(ERB.new(sh_template).result(binding))
      f.close
    end
    chmod(0755, ".git/hooks/#{hook}")

    # mkdir hook/
    sub_dir = Pathname.new("git_hooks/" + hook + "/")
    mkdir_p sub_dir

    # copy hook/sample.rb.erb
    template = File.read( File.expand_path("../../templates/" + hook + "/sample.rb", __FILE__) )
    file = sub_dir.join('sample.rb.erb')
    File.open(file, 'w+') do |f|
      f.write(ERB.new(template).result(binding))
      f.close
    end
  end
  puts '''
=================
install done !
installed to git_hooks/ !
'''
end
