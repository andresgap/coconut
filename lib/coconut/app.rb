module Coconut

  class App

    COCONUT_CONFIG_FILE = '.coconut'
    attr_reader :path, :command

    def self.current
      App.new(path: Dir.pwd)
    end

    def swap(customer:)
      puts "Swapping the configuration for #{customer}"
      raise 'No coconut instance detected' if new?
      switchable_files.each { |file, value| switch_file(file: file, customer: customer) }
      CacheService.new.clear
    end

    def init
      generate_config if new?
    end

    private

    def initialize(path:)
      @path = path
    end

    def new?
      !File.exist?(COCONUT_CONFIG_FILE)
    end

    def generate_config
      Generators::ConfigFile.start
    end

    def switchable_files
      Configuration.instance.switchable_files
    end

    def switch_file(file:, customer:)
      puts "Swapping #{file} ..."
      server_file = Configuration
        .instance
        .config_folder
        .customer_config_file(file: file, customer: customer)
      command.copy(server_file, config_file(file))
    end

    def config_file(file)
      "./config/#{file}"
    end

    def command
      @command ||= CommandInterface.new
    end

  end

end
