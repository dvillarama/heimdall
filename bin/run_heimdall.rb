#!/usr/bin/env ruby
$LOAD_PATH.unshift File.join(File.dirname(__FILE__), '..', 'lib')
require 'heimdall'
require 'dante'

Heimdall::Rules.create 'Applications' do
  regex         '^(?<measure_time>.*) sp.*imported (?<value>.*) new apps.*$'
  sample        'Mar 28 20:48:17 sp440-analysis_env interview:  [info] etl-applicaiton: imported 23 new apps in 182.311584975 seconds'
  sample_result "measure_time" => "Mar 28 20:48:17", "value" => "23"
  metric_name   :applications
  type          :counter
end

Heimdall::Rules.create 'Approved Applications' do
  regex         '^(?<measure_time>.*) sp.*Annotated (?<value>.*) approved.*$'
  sample        'Mar 27 17:04:54 sp440-analysis_env servicing_etl:  [notice] Annotated 13 approved applications with LAPro loan ID in 339.024235519 seconds'
  sample_result "measure_time" => "Mar 27 17:04:54", "value" => "13"
  metric_name   :approved_applications
  type          :counter
end

Heimdall::Rules.create 'LaPro History' do
  regex         '^(?<measure_time>.*) sp.*ETL::LaProHistoryRaw: destination count\W*(?<value>.*)$'
  sample        'Mar 31 23:20:14 sp440-analysis_env etl:  [info] ETL::LaProHistoryRaw: destination count   2512774'
  sample_result "measure_time" => "Mar 31 23:20:14" , "value" => "2512774"
  metric_name   :lapro_history
  type          :gauge
end

Heimdall::Rules.create 'LaPro Loan' do
  regex         '^(?<measure_time>.*) sp.*ETL::LaProLoanRaw: destination count\W*(?<value>.*)$'
  sample        'Mar 31 23:11:36 sp440-analysis_env etl:  [info] ETL::LaProLoanRaw: destination count   124834'
  sample_result "measure_time" => "Mar 31 23:11:36" , "value" => "124834"
  metric_name   :lapro_loan
  type          :gauge
end

Heimdall::Rules.create 'LaPro Edits' do
  regex         '^(?<measure_time>.*) sp.*ETL::LaProEditsRaw: destination count\W*(?<value>.*)$'
  sample        'Mar 31 23:15:08 sp440-analysis_env etl:  [info] ETL::LaProEditsRaw: destination count   621418'
  sample_result "measure_time" => "Mar 31 23:15:08" , "value" => "621418"
  metric_name   :lapro_edits
  type          :gauge
end

Heimdall::Rules.create 'LaPro GLTR' do
  regex         '^(?<measure_time>.*) sp.*ETL::LaProGltrRaw: destination count\W*(?<value>.*)$'
  sample        'Mar 31 23:27:08 sp440-analysis_env etl:  [info] ETL::LaProGltrRaw: destination count   46219619'
  sample_result "measure_time" => "Mar 31 23:27:08" , "value" => "46219619"
  metric_name   :lapro_gltr
  type          :gauge
end

Heimdall::Rules.create 'Telephony Calls' do
  regex         '^(?<measure_time>.*) sp.*ETL::TelephonyCall: destination count\W*(?<value>.*)$'
  sample        'Apr 01 00:15:11 sp440-analysis_env etl:  [info] ETL::TelephonyCall: destination count   3759401'
  sample_result "measure_time" => "Apr 01 00:15:11" , "value" => "3759401"
  metric_name   :telephony_calls
  type          :gauge
end

Heimdall::Rules.create 'Telephony Conversations' do
  regex         '^(?<measure_time>.*) sp.*ETL::TelephonyConversation: destination count\W*(?<value>.*)$'
  sample        'Apr 01 00:15:15 sp440-analysis_env etl:  [info] ETL::TelephonyConversation: destination count   1989923'
  sample_result "measure_time" => "Apr 01 00:15:15" , "value" => "1989923"
  metric_name   :telephony_conversations
  type          :gauge
end

Heimdall::Rules.create 'Csrs' do
  regex         '^(?<measure_time>.*) sp.*imported (?<value>.*) total CSRs.*$'
  sample        'Apr 01 00:25:28 sp440-analysis_env interview_csr_etl:  [notice] imported 699 total CSRs in table csrs'
  sample_result "measure_time" => "Apr 01 00:25:28"  , "value" => "699"
  metric_name   :csrs
  type          :gauge
end

Heimdall::Rules.create 'Csr Daily Snapshot' do
  regex         '^(?<measure_time>.*) sp.*imported (?<value>.*) new CSR.*$'
  sample        'Apr 01 00:25:28 sp440-analysis_env interview_csr_etl:  [notice] imported 699 new CSR records in csr_daily_snapshots'
  sample_result "measure_time" => "Apr 01 00:25:28" , "value" => "699"
  metric_name   :csr_daily_snapshot
  type          :gauge
end

Heimdall::Rules.create 'Twilio Agent Status' do
  regex         '^(?<measure_time>.*) sp.*Imported (?<value>.*) new Twilio agents.*$'
  sample        "Mar 31 03:34:58 sp440-analysis_env twilio_agent_status_etl:  [notice] Imported 7460 new Twilio agents' statuses'."
  sample_result "measure_time" => "Mar 31 03:34:58" , "value" => "7460"
  metric_name   :twilio_agent_status
  type          :gauge
end

Heimdall::Rules::validate

Dante::Runner.new('heimdall').execute(:daemonize => true, :pid_path => "/tmp/path.pid", :log_path => '/tmp/heimdall.out') do
  while true
    Heimdall::Log.logger.info 'running...'
    Heimdall::Rules.process Heimdall::Collector.new.collect
    sleep 300
  end
end
