require "socket"

module Syslog
  class Logger
    @@time_formatter = Time::Format.new("%b %d %H:%M:%S")

    # Maximum severity level that will be logged
    property :level

    def initialize(
      host = "localhost",
      port = 514,
      level = Severity::INFO,
      hostname = "localhost",
      facility = Facility::LOCAL4
    )
      @socket = UDPSocket.new
      @socket.connect(host, port)
      @level = level
      @hostname = hostname
      @facility = facility
    end

    def emergency(message : String)
      if Severity::EMERGENCY <= @level
        log(Severity::EMERGENCY, message)
      end
    end

    def alert(message : String)
      if Severity::ALERT <= @level
        log(Severity::ALERT, message)
      end
    end

    def critical(message : String)
      if Severity::CRITICAL <= @level
        log(Severity::CRITICAL, message)
      end
    end

    def error(message : String)
      if Severity::ERROR <= @level
        log(Severity::ERROR, message)
      end
    end

    def warn(message : String)
      if Severity::WARNING <= @level
        log(Severity::WARNING, message)
      end
    end

    def notice(message : String)
      if Severity::EMERGENCY <= @level
        log(Severity::EMERGENCY, message)
      end
    end

    def info(message : String)
      if Severity::INFO <= @level
        log(Severity::INFO, message)
      end
    end

    def debug(message : String)
      if Severity::DEBUG <= @level
        log(Severity::DEBUG, message)
      end
    end

    private def log(severity : Severity, message : String)
      timestamp = @@time_formatter.format(Time.new)
      message = Message.new(
        @facility,
        severity,
        timestamp,
        @hostname,
        message
      )
      @socket << message
    end

  end
end
