module Syslog
  enum Facility
    # kernel messages
    KERNEL
    # user-level messages
    USER
    # mail system
    MAIL
    # system daemons
    DAEMONS
    # security/authorization messages
    SECURITY1
    # messages generated internally by syslogd
    SYSLOGD
    # line printer subsystem
    PRINTER
    # network news subsystem
    NETWORK
    # UUCP subsystem
    UUCP
    # clock daemon
    CLOCK1
    # security/authorization messages (note 1)
    SECURITY2
    # FTP daemon
    FTP
    # NTP subsystem
    NTP
    # log audit
    LOG_AUDIT
    # log alert
    LOG_ALERT
    # clock daemon
    CLOCK2
    # local use 0  (local0)
    LOCAL0
    # local use 1  (local1)
    LOCAL1
    # local use 2  (local2)
    LOCAL2
    # local use 3  (local3)
    LOCAL3
    # local use 4  (local4)
    LOCAL4
    # local use 5  (local5)
    LOCAL5
    # local use 6  (local6)
    LOCAL6
    # local use 7  (local7)
    LOCAL7
  end
end
