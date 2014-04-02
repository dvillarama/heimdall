require 'httparty'

module Heimdall
  class BoardPusher

    DUCKSBOARD_PASSWORD = Settings.ducksboard['password']
    DUCKSBOARD_API_KEY  = Settings.ducksboard['api_key']

    def self.request(address, payload = {}, method = :post)
      payload = payload.to_json unless payload.empty?
      result = HTTParty.__send__ method, address, :basic_auth => auth, :body => payload
      Log.logger.info "#{method} #{payload} to #{address} resulting in #{JSON.parse result.body}"
    end

    def self.auth
      { :username => DUCKSBOARD_API_KEY, :password => DUCKSBOARD_PASSWORD }
    end
  end
end
