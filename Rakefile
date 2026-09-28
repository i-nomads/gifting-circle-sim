require 'rake/testtask'

Rake::TestTask.new(:test) do |t|
  t.test_files = FileList['test/**/*_test.rb']
end

namespace :db do
  desc 'Wipe all users and circles and load the seed data'
  task :reset do
    require_relative 'app'
    Seeds.reset!
  end
end

task default: :test
