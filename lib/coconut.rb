require 'yaml'

module Coconut
  # CONFIG = YAML.load_file(File.join(GEM_ROOT, 'config/coconut.yml'))
  # CUSTOMERS_PATH = File.join(GEM_ROOT, Coconut::CONFIG['local']['customer_path'])
end

require_relative "coconut/version"
require_relative 'coconut/cache_service'
require_relative 'coconut/swap_service'
require_relative 'coconut/fetch_service'
require_relative 'coconut/command_interface'
