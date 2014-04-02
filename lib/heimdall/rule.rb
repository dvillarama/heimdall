require 'Date'

module Heimdall
  class Rule
    attr_accessor :name, :match_error

    def initialize(name)
      @name = name
    end

    def parse(data)
      matches = @regex.match data
      massage matches if matches
    end

    def massage matches
      data = Hash[matches.names.zip matches.captures]
      timestampify! data
      data
    end

    def timestampify! data
      date = data['timestamp']
      data['timestamp'] = DateTime.parse(date).to_time.to_i if date
    end

    def regex(regex)
      @regex = Regexp.new regex
    end

    def validate!
      matches = @regex.match @sample

      unless matches
        self.match_error = "Regex did not match #{@sample_result}"
        return
      end

      data = Hash[matches.names.zip matches.captures]
      self.match_error = "#{data} does not match #{@sample_result}" if data != @sample_result
    end

    def post log
      data = parse log
      BoardPusher.request @url, data if data
    end

    def self.setter(*method_names)
      method_names.each do |name|
        send :define_method, name do |data|
          instance_variable_set "@#{name}".to_sym, data
        end
      end
    end

    setter :sample, :sample_result, :url
  end
end
