module Coconut
  class FetchService

    def initialize(customer:)
      @customer = customer
      @server_config = Coconut::CONFIG['server']
      @command = CommandInterface.new
    end

    def start
      puts "Fetching config files from #{customer}"
      config_files.each do |file, config|
        fetch_file(file)
        convert_file(file) if file.end_with?('.yml')
      end
    end

    private

    attr_accessor :customer
    attr_accessor :server_config
    attr_accessor :command

    def config_files
      Coconut::CONFIG['local']['config_files']
    end

    def fetch_file(file)
      puts "Fetching #{file} ..."
      origin = "#{server_config['shared_folder']}/#{file}"
      command.fetch(ssh_user, address, origin, server_file(file))
    end

    def ssh_user
      server_config['ssh_user']
    end

    def address
      server_config['customers'][customer]['address']
    end

    def server_file(file)
      "#{customers_path}/#{file}.#{customer}"
    end

    def customers_path
      path = "#{Rails.root}/#{Coconut::CONFIG['local']['customer_path']}"
      FileUtils.mkdir_p(path) unless File.exist?(path)
      path
    end

    def convert_file(file)
      path = server_file(file)
      content = read_yml(path)
      yaml = { 'development' => content }
      write_yml(path, yaml.to_yaml)
    end

    def write_yml(path, content)
      File.open(path, 'w') { |file| file.write(content) }
    end

    def read_yml(path)
      YAML.load_file(path)['integration']
    end
  end
end
