require "socket"

module Syslog
  class Logger
    @@time_formatter = Time::Format.new("%b %d %H:%M:%S")

    @socket : Socket

    @level : Syslog::Severity

    def initialize(
                   @hostname = "localhost",
                   @appname : String? = nil,
                   @facility = Facility::LOCAL4,
                   @remote = false,
                   @syslog_host = "localhost",
                   @syslog_port = 514)
      @level = Severity::INFO
      if remote
        udp_socket = UDPSocket.new
        udp_socket.connect(@syslog_host, @syslog_port)
        @socket = udp_socket
      else
        @socket = UNIXSocket.new("/dev/log", Socket::Type::DGRAM)
      end
    end

    def emergency(message : String)
      log(Severity::EMERGENCY, message)
    end

    def alert(message : String)
      log(Severity::ALERT, message)
    end

    def critical(message : String)
      log(Severity::CRITICAL, message)
    end

    def error(message : String)
      log(Severity::ERROR, message)
    end

    def warn(message : String)
      log(Severity::WARNING, message)
    end

    def notice(message : String)
      log(Severity::EMERGENCY, message)
    end

    def info(message : String)
      log(Severity::INFO, message)
    end

    def debug(message : String)
      log(Severity::DEBUG, message)
    end

    private def log(severity : Severity, message : String)
      return if severity.value > @level.value

      timestamp = @@time_formatter.format(Time.new)
      message = Message.new(
        @facility,
        severity,
        timestamp,
        @hostname,
        @appname,
        message
      )
      @socket << message.to_s
      @socket.flush
    end
  end
end
