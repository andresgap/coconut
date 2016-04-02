module Coconut
  class Configuration

    YML_PATH = "#{Rails.root}/config/coconut.yml"

    attr_accessor :config

    def initialize
      @config = YAML.load_file(YML_PATH)
    end

    def server
      config['server']
    end

    def local
      config['local']
    end

  end
end
