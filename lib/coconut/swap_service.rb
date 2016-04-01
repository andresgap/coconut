module Coconut
  class SwapService

    def initialize(customer:)
      @customer = customer
      @command = CommandInterface.new
    end

    def start
      puts "Swapping the configuration for #{customer}"
      config_files.each { |file, config| swap_file(file) }
      clear_caches
    end

    private

    attr_accessor :customer
    attr_accessor :command

    def clear_caches
      CacheService.new(command).clear
    end

    def config_files
      Coconut::CONFIG['local']['config_files'].select { |key, config| config['swap'] }
    end

    def swap_file(file)
      puts "Swapping #{file} ..."
      command.copy(server_file(file), config_file(file))
    end

    def server_file(file)
      "#{CUSTOMERS_PATH}/#{file}.#{customer}"
    end

    def config_file(file)
      "#{Rails.root}/config/#{file}"
    end

  end
end
