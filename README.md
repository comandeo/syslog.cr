# Syslog.cr
[![Build Status](https://travis-ci.org/comandeo/syslog.cr.svg?branch=master)](https://travis-ci.org/comandeo/syslog.cr)

Syslog client implementation for Crystal (work in progress!)

## Installation


Add this to your application's `shard.yml`:

```yaml
dependencies:
  syslog:
    github: comandeo/syslog.cr
```

## Usage


```crystal
require "syslog"
# Use local syslog with defaults:
# - logging to `/dev/log`
# - syslog port: 514
# - log level: INFO
# - application hostname: localhost
# - application name: ""
# - syslog facility: local4
logger = Syslog::Logger.new
logger.info("Something interesting happened")

# Use remote syslog with some custom params
logger = Syslog::Logger.new(
    remote: true,
    syslog_host: "logger.company.com",
    syslog_port: 1234,
    appname: "application.company.com",
    facility: Syslog::Facility::USER,
    level: Syslog::Severity::WARN
)

logger.error("Something bad happened")

# Set the log level
logger.level = Syslog::Severity::DEBUG

logger.debug("Some debug message")

```
## Contributing

1. Fork it ( https://github.com/comandeo/syslog/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [comandeo](https://github.com/comandeo) Dmitry Rybakov - creator, maintainer
