module Coconut
  class CacheService

    TMP_PATH = "#{Rails.root}/tmp"

    attr_accessor :command

    def initialize(command)
      @command = command
    end

    def clear
      puts 'Clearing caches ...'
      cache_entries.each { |entry| command.clear_directory(entry) }
    end

    private

    def cache_entries
      Dir.entries(TMP_PATH)
        .select { |name| name.start_with?('cache') }
        .map { |name| File.join(TMP_PATH, name) }
        .select { |file| File.directory?(file) }
    end

  end
end
