module Coconut

  class App

    COCONUT_CONFIG_FILE = '.coconut'
    attr_reader :path, :command

    def self.current
      App.new(path: Dir.pwd)
    end

    def swap(customer_name:)
      customer = Customer.init(name: customer_name)
      print "Swapping the configuration for #{customer.name} \n\n".cyan
      raise 'No coconut instance detected'.red if new?
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
      puts 'Generating .coconut configuration file'.cyan
      ssh_user = shell.ask('Set your SSH user:')
      shared_folder = shell.ask('Set shared_folder path (server path):')
      prefix = shell.ask('Set the server prefix:')
      suffix = shell.ask('Set the server suffix:')

      Generators::ConfigFile.start([ssh_user, shared_folder, prefix, suffix])
    end

    def switchable_files
      Configuration.instance.switchable_files
    end

    def switch_file(file:, customer:)
      print "Swapping #{file} ...".blue
      server_file_path = customer.local_file_path(file)
      command.copy(server_file_path, config_file(file))
      print "\rSwapping #{file} - [Sucessfull] ✔ \n".green
    rescue => e
      print "\rSwapping #{file} - [Fail] ✖ \n".red
      raise e
    end

    def config_file(file)
      "./config/#{file}"
    end

    def command
      @command ||= CommandInterface.new
    end

    def shell
      Thor::Base.shell.new
    end

  end

end
