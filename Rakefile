# encoding: utf-8

require 'rubygems'
require 'bundler/gem_tasks'
require 'stefon/rake_task'
require 'rspec/core/rake_task'


desc 'Run stefon over himself'
task :stefon do
  Stefon::RakeTask.new
end

RSpec::Core::RakeTask.new

task :test => :spec
task :default => :spec
