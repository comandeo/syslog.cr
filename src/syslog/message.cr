module Syslog
  # Message formatted according to syslog specification.
  class Message
    def initialize(
      facility : Facility,
      severity : Severity,
      timestamp : String,
      hostname : String,
      message : String
    )
      @facility = facility
      @severity = severity
      @timestamp = timestamp
      @hostname = hostname
      @message = message
    end

     def to_s(io : IO)
       io << "<#{@facility.value}#{@severity.value}> #{@timestamp} #{@hostname} #{@message}"
     end
  end
end
