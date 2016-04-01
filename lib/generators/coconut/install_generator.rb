module Coconut
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path("../templates", __FILE__)

    def copy_initializer
      template '../templates/coconut.rb.erb', 'config/initializers/coconut.rb'
      template '../templates/coconut.yml.erb', 'config/coconut.yml'
    end
  end
end
