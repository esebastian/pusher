require 'bundler/setup'
require 'rspec/core/rake_task'

task :default => :"test:spec"

namespace :test do
  RSpec::Core::RakeTask.new(:spec)
end