module Coconut

  class Customer

    attr_reader :name

    def self.init(name:)
      Customer.dynamic?(name) ? DynamicCustomer.new(name: name) : Customer.new(name: name)
    end

    def self.dynamic?(name)
      Configuration.instance.server['customers'][name].nil?
    end

    def address
      attributes['address']
    end

    def attributes
      @attributes ||= Configuration.instance.server['customers'][name]
    end

    def environment
      attributes['environment'] || 'integration'
    end

    def local_file_path(file_name)
      path = "#{customers_path}#{file_name}.#{name}"
      File.exist?(path) ? path : ""
    end

    private

    def initialize(name:)
      @name = name
    end

    def customers_path
      Configuration.instance.config_folder.customers_path
    end

  end

end
