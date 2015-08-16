require 'rools'
require 'ostruct'
require 'singleton'
require 'logger'



$logger = Logger.new(STDOUT)

class SmsEvent
    def from_whitelisted_address?
        true
    end
    def initialize
        @from = '614-123-1234'
        @message = 'arm'
    end
end

class ArmState
    include Singleton
    def handle_sms_event!(event)
        $logger.debug("Processing SMS event for arm/disarm content: #{event.inspect}")
        # set state, log stuff, history log, durable last-* in JSON/file, etc.
    end
end

sms_test_event = SmsEvent.new
$logger.debug sms_test_event.inspect

rules = Rools::RuleSet.new do
    
    rule 'SMS arm/disarm request' do
        parameter SmsEvent
        condition { self.obj }
        #condition { obj.from_whitelisted_address? }
        #consequence { ArmState.handle_sms_event!(obj) }
        consequence { puts "CONSEQUENCE" }
    end
end

rules.assert(sms_test_event)