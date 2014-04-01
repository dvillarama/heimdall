require 'gmail'

module Heimdall
  class Collector

    GMAIL_USER     = Settings.gmail['username']
    GMAIL_PASSWORD = Settings.gmail['password']

    def self.collect
      data_logs = []
      Gmail.connect(GMAIL_USER, GMAIL_PASSWORD) do |gmail|
        gmail.inbox.find(:unread).each do |email|
        # gmail.inbox.find().each do |email|
          data_logs << email.message.body.to_s.match(/Here's.*search:\n(?<data>.*)\nAbout.*/m)[:data]
          email.read!
        end
      end
      data_logs
    end
  end
end
