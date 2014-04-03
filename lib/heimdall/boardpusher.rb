require 'librato/metrics'

module Heimdall
  class BoardPusher

    LIBRATO_EMAIL   = Settings.librato['email']
    LIBRATO_API_KEY = Settings.librato['api_key']

    def self.submit(payload = {})
      authenticate
      begin
        result = Librato::Metrics.submit payload
      rescue => e
        Log.logger.error "Sending #{payload} resulting in #{e}"
      ensure
        Log.logger.info "Sending #{payload} resulting in #{result}"
      end
    end

    def self.authenticate
      Librato::Metrics.authenticate LIBRATO_EMAIL, LIBRATO_API_KEY
    end
  end
end
