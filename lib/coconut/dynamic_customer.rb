module Coconut

  class DynamicCustomer

    attr_reader :name

    def initialize(name:)
      @name = name
    end

    def address
      "#{server_prefix}-#{tenant}-#{environment_acronym}-#{server_suffix}"
    end

    def attributes
      {}
    end

    def environment
      return 'staging' unless /(stg|stage|staging)/.match(name).nil?
      return 'production' unless /(prd|prod|production)/.match(name).nil?
      return 'integration'
    end

    def local_file_path(file_name)
      path = "#{customers_path}#{file_name}.#{name}"
      File.exist?(path) ? path : ""
    end

    private

    def tenant
      tenat_with_env = /([a-z]+)-(stg|stage|staging|prd|prod|production)/.match(name)
      tenat_with_env.nil? ? name : tenat_with_env[1]
    end

    def environment_acronym
      case environment
      when 'integration'
        'dev'
      when 'staging'
        'stg'
      when 'production'
        'prd'
      end
    end

    def server_prefix
      configuration.server['prefix']
    end

    def server_suffix
      configuration.server['suffix']
    end

    def customers_path
      configuration.config_folder.customers_path
    end

    def configuration
      Configuration.instance
    end

  end

end
