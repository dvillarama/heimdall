#!/usr/bin/env ruby
#
$LOAD_PATH.unshift File.join(File.dirname(__FILE__), '..', 'lib')

require 'heimdall'

Heimdall::Rules.create 'Applications' do
  regex         '^(?<timestamp>.*) sp.*imported (?<value>.*) new apps.*$'
  sample        'Mar 28 20:48:17 sp440-analysis_env interview:  [info] etl-applicaiton: imported 23 new apps in 182.311584975 seconds'
  sample_result "timestamp" => "Mar 28 20:48:17", "value" => "23"
  url           'https://push.ducksboard.com/v/368364'
end

Heimdall::Rules.create 'Approved Applications' do
  regex         '^(?<timestamp>.*) sp.*Annotated (?<value>.*) approved.*$'
  sample        'Mar 27 17:04:54 sp440-analysis_env servicing_etl:  [notice] Annotated 13 approved applications with LAPro loan ID in 339.024235519 seconds'
  sample_result "timestamp" => "Mar 27 17:04:54", "value" => "13"
  url           'https://push.ducksboard.com/v/368365'
end

#
# Rules::validate
#

Heimdall::Rules.process Heimdall::Collector.collect
