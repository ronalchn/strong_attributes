require 'rake'
require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

task "default" => "ci"

desc "Run all tests for CI"
citask = ["spec"]
begin
  require 'coveralls/rake/task'
  Coveralls::RakeTask.new
  citask << "coveralls:push" if defined? 'Coveralls'
rescue LoadError
end
task "ci" => citask

desc "Run all specs"
task "spec" => "spec:all"

namespace "spec" do
  task "all" => ["strong_attributes"]

  def spec_task(name)
    desc "Run #{name} specs"
    RSpec::Core::RakeTask.new(name) do |t|
      t.pattern = "spec/#{name}/**/*_spec.rb"
    end
  end

  spec_task "strong_attributes"
end

