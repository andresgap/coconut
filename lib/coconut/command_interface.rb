module Coconut
  class CommandInterface

    def copy(origin, destination)
      execute("cp #{origin} #{destination}")
    end

    def clear_directory(path)
      execute("rm -rf #{path}")
    end

    def fetch(user, address, origin, destination)
      execute("scp #{user}@#{address}:#{origin} #{destination}")
    end

    private

    def execute(command)
      Open3.popen3(command) do |std_in, std_out, std_err, wait_thread|
        raise std_err.readlines.join("\n") unless wait_thread.value.success?
      end
    end

  end
end
