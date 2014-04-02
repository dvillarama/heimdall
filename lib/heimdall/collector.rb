require 'gmail'

module Heimdall
  class Collector
    include Heimdall::Log

    GMAIL_USER     = Settings.gmail['username']
    GMAIL_PASSWORD = Settings.gmail['password']

    def collect
      data_logs = []

      regex = Regexp.new("^.*search:\n(?<data>.*)\nAbout.*$", Regexp::MULTILINE)

      Gmail.connect(GMAIL_USER, GMAIL_PASSWORD) do |gmail|
        logger.info 'Connected to gmail...'
        gmail.inbox.find(:unread).each do |email|
          logger.info ' processing an email...'
          data_logs << regex.match(email.message.body.to_s)[:data]
          email.read!
        end
      end

      logger.info "Found #{data_logs.count} logs"
      data_logs
    end
  end
end
