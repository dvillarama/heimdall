module Heimdall
  class Rules
    class << self
      attr_accessor :rules
    end

    def self.create(name, &block)
      self.rules ||= []

      new_rule = Rule.new name
      new_rule.instance_eval(&block)
      self.rules << new_rule
    end

    def self.validate
      rules.each do |rule|
        rule.validate!
        p "Rule: #{rule.name} is #{rule.match_error ? 'not valid' : 'valid'}"
        p "   -> #{rule.match_error}" if rule.match_error
      end
    end

    def self.process(data_logs)
      data_logs.each do |log|
        rules.each do |rule|
          rule.post log
        end
      end
    end
  end
end
