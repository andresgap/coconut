require 'open3'

module Coconut

  class CommandInterface

    def copy(origin, destination)
      execute("cp #{origin} #{destination}")
    end

    def clear_directory(path)
      execute("rm -rf #{path}")
    end

    def fetch(address, origin, destination)
      execute("scp #{ssh_user}@#{address}:#{origin} #{destination}")
    end

    private

    def execute(command)
      Open3.popen3(command) do |std_in, std_out, std_err, wait_thread|
        raise std_err.readlines.join("\n") unless wait_thread.value.success?
      end
    end

    def ssh_user
      Configuration.instance.ssh_user
    end

  end

end
