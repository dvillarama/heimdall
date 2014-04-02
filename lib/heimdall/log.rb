require 'logger'

module Heimdall
  module Log
    def logger
      Log.logger
    end

    def self.logfile
      ::File.expand_path(::File.join(::File.dirname(__FILE__), '..', '..', 'log', 'heimdall.log'))
    end

    def self.logger
      @logger ||= Logger.new(self.logfile, shift_age = 7, shift_size = 1048576)
    end
  end
end
