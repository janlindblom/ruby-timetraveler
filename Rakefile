require "bundler/gem_tasks"
require "yard"
require "yard/rake/yardoc_task"

Dir.glob('rake/*.rake').each { |r| load r}

YARD::Rake::YardocTask.new do |t|
  t.files   = ['lib/**/*.rb']
  t.stats_options = ['--list-undoc']
end

begin
  require 'rspec/core/rake_task'
  namespace :spec do
    RSpec::Core::RakeTask.new(:offline) do |t, task_args|
      t.rspec_opts = "--tag offline"
    end

    RSpec::Core::RakeTask.new(:online) do |t, task_args|
      t.rspec_opts = "--tag online"
    end

    RSpec::Core::RakeTask.new(:all) do |t, task_args|
      t.rspec_opts = "--tag online --tag offline"
    end
  end

  task spec: "spec:all"

  task default: :spec
rescue LoadError
end
