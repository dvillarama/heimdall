#!/usr/bin/env ruby
$LOAD_PATH.unshift File.join(File.dirname(__FILE__), '..', 'lib')
require 'heimdall'
require 'dante'

Heimdall::Rules.create 'Applications' do
  regex         '^(?<timestamp>.*) sp.*imported (?<value>.*) new apps.*$'
  sample        'Mar 28 20:48:17 sp440-analysis_env interview:  [info] etl-applicaiton: imported 23 new apps in 182.311584975 seconds'
  sample_result "timestamp" => "Mar 28 20:48:17", "value" => "23"
  url           'https://push.ducksboard.com/v/371266'
end

Heimdall::Rules.create 'Approved Applications' do
  regex         '^(?<timestamp>.*) sp.*Annotated (?<value>.*) approved.*$'
  sample        'Mar 27 17:04:54 sp440-analysis_env servicing_etl:  [notice] Annotated 13 approved applications with LAPro loan ID in 339.024235519 seconds'
  sample_result "timestamp" => "Mar 27 17:04:54", "value" => "13"
  url           'https://push.ducksboard.com/v/371267'
end

Heimdall::Rules.create 'LaPro History' do
  regex         '^(?<timestamp>.*) sp.*ETL::LaProHistoryRaw: destination count\W*(?<value>.*)$'
  sample        'Mar 31 23:20:14 sp440-analysis_env etl:  [info] ETL::LaProHistoryRaw: destination count   2512774'
  sample_result "timestamp" => "Mar 31 23:20:14" , "value" => "2512774"
  url           'https://push.ducksboard.com/v/371252 '
end

Heimdall::Rules.create 'LaPro Loan' do
  regex         '^(?<timestamp>.*) sp.*ETL::LaProLoanRaw: destination count\W*(?<value>.*)$'
  sample        'Mar 31 23:11:36 sp440-analysis_env etl:  [info] ETL::LaProLoanRaw: destination count   124834'
  sample_result "timestamp" => "Mar 31 23:11:36" , "value" => "124834"
  url           'https://push.ducksboard.com/v/371272'
end

Heimdall::Rules.create 'LaPro Edits' do
  regex         '^(?<timestamp>.*) sp.*ETL::LaProEditsRaw: destination count\W*(?<value>.*)$'
  sample        'Mar 31 23:15:08 sp440-analysis_env etl:  [info] ETL::LaProEditsRaw: destination count   621418'
  sample_result "timestamp" => "Mar 31 23:15:08" , "value" => "621418"
  url           'https://push.ducksboard.com/v/371286'
end

Heimdall::Rules.create 'LaPro GLTR' do
  regex         '^(?<timestamp>.*) sp.*ETL::LaProGltrRaw: destination count\W*(?<value>.*)$'
  sample        'Mar 31 23:27:08 sp440-analysis_env etl:  [info] ETL::LaProGltrRaw: destination count   46219619'
  sample_result "timestamp" => "Mar 31 23:27:08" , "value" => "46219619"
  url           'https://push.ducksboard.com/v/371273'
end

Heimdall::Rules.create 'Telephony Calls' do
  regex         '^(?<timestamp>.*) sp.*ETL::TelephonyCall: destination count\W*(?<value>.*)$'
  sample        'Apr 01 00:15:11 sp440-analysis_env etl:  [info] ETL::TelephonyCall: destination count   3759401'
  sample_result "timestamp" => "Apr 01 00:15:11" , "value" => "3759401"
  url           'https://push.ducksboard.com/v/371287 '
end

Heimdall::Rules.create 'Telephony Calls' do
  regex         '^(?<timestamp>.*) sp.*ETL::TelephonyConversation: destination count\W*(?<value>.*)$'
  sample        'Apr 01 00:15:15 sp440-analysis_env etl:  [info] ETL::TelephonyConversation: destination count   1989923'
  sample_result "timestamp" => "Apr 01 00:15:15" , "value" => "1989923"
  url           'https://push.ducksboard.com/v/371288'
end

Heimdall::Rules.create 'Csrs' do
  regex         '^(?<timestamp>.*) sp.*imported (?<value>.*) total CSRs.*$'
  sample        'Apr 01 00:25:28 sp440-analysis_env interview_csr_etl:  [notice] imported 699 total CSRs in table csrs'
  sample_result "timestamp" => "Apr 01 00:25:28"  , "value" => "699"
  url           'https://push.ducksboard.com/v/371318'
end

Heimdall::Rules.create 'Csr Daily Snapshot' do
  regex         '^(?<timestamp>.*) sp.*imported (?<value>.*) new CSR.*$'
  sample        'Apr 01 00:25:28 sp440-analysis_env interview_csr_etl:  [notice] imported 699 new CSR records in csr_daily_snapshots'
  sample_result "timestamp" => "Apr 01 00:25:28" , "value" => "699"
  url           'https://push.ducksboard.com/v/371321'
end

Heimdall::Rules.create 'Twilio Agent Status' do
  regex         '^(?<timestamp>.*) sp.*Imported (?<value>.*) new Twilio agents.*$'
  sample        "Mar 31 03:34:58 sp440-analysis_env twilio_agent_status_etl:  [notice] Imported 7460 new Twilio agents' statuses'."
  sample_result "timestamp" => "Mar 31 03:34:58" , "value" => "7460"
  url           'https://push.ducksboard.com/v/371325'
end

Heimdall::Rules::validate

Dante::Runner.new('heimdall').execute(:daemonize => true, :pid_path => "/tmp/path.pid", :log_path => '/tmp/heimdall.out') do
  while true
    Heimdall::Log.logger.info 'running...'
    Heimdall::Rules.process Heimdall::Collector.new.collect
    sleep 300
  end
end
