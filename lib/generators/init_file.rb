require 'thor'
require 'thor/group'

module Generators
  class ConfigFile < Thor::Group
    include Thor::Actions

    desc 'Generate the configuration of a coconut instance on folder'

    def self.source_root
      File.dirname(__FILE__) + '/coconut/templates'
    end

    def create_lib_file
      template('coconut.tt', '.coconut')
    end

  end
end
