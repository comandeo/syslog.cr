# syslog.cr

Syslog client implementation for Crystal

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
# Use defaults:
# - syslog host: localhost
# - syslog port: 514
# - log level: INFO
# - application hostname: localhost
# - syslog facility: local4
logger = Syslog::Logger.new
logger.info("Something happened")

# Use custom params
logger = Syslog::Logger.new(
    "logger.company.com",
    1234,
    Syslog::Severity::WARNING,
    "application.company.com",
    Syslog::Facility::USER
)

logger.error("Something happened")

```
## Contributing

1. Fork it ( https://github.com/comandeo/syslog/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [comandeo](https://github.com/comandeo) Dmitry Rybakov - creator, maintainer
