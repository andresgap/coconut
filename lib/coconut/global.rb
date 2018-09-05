module Coconut

  class Global

    def self.install
      configure.config_folder.install
    end

    private

    def self.configure
      Coconut::Configuration.instance
    end

  end

end
