module Syslog
  # Message formatted according to syslog specification.
  class Message
    def initialize(
      @facility : Facility,
      @severity : Severity,
      @timestamp : String,
      @hostname : String,
      @appname : String,
      @message : String
    )
    end

     def to_s(io : IO)
       io << "<#{@facility.value}#{@severity.value}>#{@timestamp} #{@hostname} #{@appname}: #{@message}"
     end
  end
end
