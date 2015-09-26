module Syslog
  # Severity level indicator
  enum Severity
    # Emergency: system is unusable
    EMERGENCY
    # Alert: action must be taken immediately
    ALERT
    # Critical: critical conditions
    CRITICAL
    # Error: error conditions
    ERROR
    # Warning: warning conditions
    WARNING
    # Notice: normal but significant condition
    NOTICE
    # Informational: informational messages
    INFO
    # Debug: debug-level messages
    DEBUG
  end
end
