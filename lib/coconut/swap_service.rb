module Coconut
  class SwapService

    def initialize(customer:)
      @customer = customer
      @config = Configuration.new
      @command = CommandInterface.new
    end

    def start
      puts "Swapping the configuration for #{customer}"
      config_files.each { |file, value| swap_file(file) }
      clear_caches
    end

    private

    attr_accessor :customer
    attr_accessor :config
    attr_accessor :command

    def clear_caches
      CacheService.new(command).clear
    end

    def config_files
      config.local['config_files'].select { |key, value| value['swap'] }
    end

    def swap_file(file)
      puts "Swapping #{file} ..."
      command.copy(server_file(file), config_file(file))
    end

    def server_file(file)
      "#{customers_path}/#{file}.#{customer}"
    end

    def customers_path
      "#{Rails.root}/#{config.local['customer_path']}"
    end

    def config_file(file)
      "#{Rails.root}/config/#{file}"
    end

  end
end
