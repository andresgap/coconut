module Coconut

  class Server

    attr_reader :customer

    def self.from(customer_name:)
      customer = Customer.init(name: customer_name)
      Server.new(customer: customer)
    end

    def fetch
      print "Fetching config files from #{customer.name} \n\n".cyan
      Configuration.instance.config_files.each do |file, config|
        RemoteFile.new(name: file, customer: customer).fetch
      end
    end

    private

    def initialize(customer:)
      @customer = customer
    end

  end

end
