require "../spec_helper"

describe Syslog::Logger do
  context "remote" do
    it "logs info message to default facility" do
      time_formatter = Time::Format.new("%b %d %H:%M:%S")
      server = UDPSocket.new
      server.bind("localhost", 1234)

      logger = Syslog::Logger.new(
        remote: true,
        syslog_host: "localhost",
        syslog_port: 1234
      )
      expected_message = "<206>#{time_formatter.format(Time.new)} localhost \
        [#{Process.pid}]: [INFO] Hello, world! We use remote syslog!"
      logger.info("Hello, world! We use remote syslog!")
      message = server.gets(expected_message.bytesize)
      server.close
      message.should eq(expected_message)
    end
  end

  it "logs with custom facility" do
    time_formatter = Time::Format.new("%b %d %H:%M:%S")
    server = UDPSocket.new
    server.bind("localhost", 1234)

    logger = Syslog::Logger.new(
      facility: Syslog::Facility::LOCAL1,
      remote: true,
      syslog_host: "localhost",
      syslog_port: 1234
    )
    expected_message = "<176>#{time_formatter.format(Time.new)} localhost \
      [#{Process.pid}]: [INFO] Hello, world! We use remote syslog!"
    logger.info("Hello, world! We use remote syslog!")
    message = server.gets(expected_message.bytesize)
    server.close
    message.should eq(expected_message)
  end

  it "logs with custom level" do
    time_formatter = Time::Format.new("%b %d %H:%M:%S")
    server = UDPSocket.new
    server.bind("localhost", 1234)

    logger = Syslog::Logger.new(
      level: Syslog::Severity::DEBUG,
      facility: Syslog::Facility::LOCAL1,
      remote: true,
      syslog_host: "localhost",
      syslog_port: 1234
    )
    debug_message = "<177>#{time_formatter.format(Time.new)} localhost \
      [#{Process.pid}]: [DEBUG] Hello, world! We use remote syslog!"

    logger.debug("Hello, world! We use remote syslog!")
    message, _client_addr = server.receive


    warn_message = "<174>#{time_formatter.format(Time.new)} localhost \
      [#{Process.pid}]: [WARNING] Hello, world! We use remote syslog!"

    logger.warn("Hello, world! We use remote syslog!")
    message2, _client_addr = server.receive
    server.close

    message.should eq(debug_message)
    message2.should eq(warn_message)
  end

  it "can change the log level" do
    time_formatter = Time::Format.new("%b %d %H:%M:%S")
    server = UDPSocket.new
    server.bind("localhost", 1234)
    server.read_timeout = Time::Span.new(nanoseconds: 300_000_000)

    logger = Syslog::Logger.new(
      facility: Syslog::Facility::LOCAL1,
      level: Syslog::Severity::INFO,
      remote: true,
      syslog_host: "localhost",
      syslog_port: 1234
    )

    # We shouldn't get debug level messages
    logger.debug("Hello, world! We use remote syslog!")
    expect_raises(IO::Timeout) do
      _message, _client_addr = server.receive
    end


    logger.level = Syslog::Severity::DEBUG

    # Now we should
    debug_message = "<177>#{time_formatter.format(Time.new)} localhost \
      [#{Process.pid}]: [DEBUG] Hello, world! We use remote syslog!"
    logger.debug("Hello, world! We use remote syslog!")
    message2, _client_addr = server.receive
    server.close

    message2.should eq(debug_message)
  end

  it "logs with custom hostname" do
    time_formatter = Time::Format.new("%b %d %H:%M:%S")
    server = UDPSocket.new
    server.bind("localhost", 1234)

    logger = Syslog::Logger.new(
      hostname: "app.company.com",
      remote: true,
      syslog_host: "localhost",
      syslog_port: 1234
    )
    expected_message = "<206>#{time_formatter.format(Time.new)} app.company.com \
      [#{Process.pid}]: [INFO] Hello, world! We use remote syslog!"
    logger.info("Hello, world! We use remote syslog!")
    message = server.gets(expected_message.bytesize)
    server.close
    message.should eq(expected_message)
  end

  it "logs with custom app name" do
    time_formatter = Time::Format.new("%b %d %H:%M:%S")
    server = UDPSocket.new
    server.bind("localhost", 1234)

    logger = Syslog::Logger.new(
      appname: "GreatApp",
      remote: true,
      syslog_host: "localhost",
      syslog_port: 1234
    )
    expected_message = "<206>#{time_formatter.format(Time.new)} localhost \
      GreatApp [#{Process.pid}]: [INFO] Hello, world! We use remote syslog!"
    logger.info("Hello, world! We use remote syslog!")
    message = server.gets(expected_message.bytesize)
    server.close
    message.should eq(expected_message)
  end
end
