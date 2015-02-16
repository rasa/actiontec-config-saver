#!/usr/bin/env ruby

require './actiontecconfigsaver.rb'

acs = ActiontecConfigSaver.new

begin
  require './config.rb'
  acs.host = ACS_HOST if defined? ACS_HOST
  acs.user = ACS_USER if defined? ACS_USER
  acs.pass = ACS_PASS if defined? ACS_PASS
  acs.domain = ACS_DOMAIN if defined? ACS_DOMAIN
rescue
end

acs.run

# EOF
