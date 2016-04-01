require "bundler/gem_tasks"
require 'bundler/setup'

ENV['RACK_ENV'] ||= 'development'
Bundler.require(:default, ENV['RACK_ENV'])
Dir["lib/tasks/**/*.rake"].each { |ext| load ext }
