module Coconut

  class Global

    def self.install
      p 'Creating config folder...'
      configure.config_folder.install
    end

    private

    def self.configure
      Coconut::Configuration.instance
    end

  end

end
