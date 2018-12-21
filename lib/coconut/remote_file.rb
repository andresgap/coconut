module Coconut

  class RemoteFile

    attr_reader :path
    attr_reader :name
    attr_reader :customer

    class NoRemoteFileFound < StandardError; end
    class NoAccessServer < StandardError; end

    def initialize(name:, customer:)
      @name = name
      @customer = customer
    end

    def fetch
      print "Fetching #{name} ...".blue
      fetch_from_server
      convert_file if (name.end_with?('.yml') && enviroment_base_file?)
      print "\rFetching #{name} - [Sucessfull] ✔ \n".green
    rescue => e
      print "\rFetching #{name} - [Fail] ✖ \n".red
      raise e
    end

    private

    def fetch_from_server
      Open3.popen3(fetch_command_string) do |std_in, std_out, std_err, wait_thread|
        raise std_err.readlines.join("\n") unless wait_thread.value.success?
      end
    end

    def fetch_command_string
      "scp #{configuration.ssh_user}@#{customer.address}:#{origin_path} #{local_path}"
    end

    def configuration
      Configuration.instance
    end

    def origin_path
      "#{configuration.share_folder}/#{name}"
    end

    def local_path
      "#{configuration.config_folder.customers_path}/#{name}.#{customer.name}"
    end

    def enviroment_base_file?
      !environment_content.nil?
    end

    def convert_file
      output = overwrite_content
      yaml = { 'development' => output }
      write_yml(yaml.to_yaml)
    end

    def overwrite_content
      output = content.clone
      file_attributes = overwrite_file_attributes
      return output unless file_attributes
      file_attributes.each do |attribute, value|
        output[attribute] = value
      end

      output
    end

    def content
      @content ||= read_yml
    end

    def write_yml(content)
      File.open(local_path, 'w') { |file| file.write(content) }
    end

    def read_yml
      return environment_content if enviroment_base_file?
      return raw_content
    end

    def raw_content
      @raw_content ||= YAML.load_file(local_path)
    end

    def environment_content
      @environment_content ||= raw_content[customer.environment]
    end

    def overwrite_file_attributes
      general_attributes = configuration.general_config[name]
      return general_attributes.merge(customer.attributes[name] || {}) if general_attributes
      customer.attributes[name]
    end

  end

end
