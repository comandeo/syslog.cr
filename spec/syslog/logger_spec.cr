require "../spec_helper"

describe Syslog::Logger do
  it "logs info message to default facility" do
    time_formatter = Time::Format.new("%b %d %H:%M:%S")
    server = UDPSocket.new
    server.bind("localhost", 1234)
    logger = Syslog::Logger.new(
      "localhost",
      1234
    )
    expected_message = "<206> #{time_formatter.format(Time.new)} localhost Hello, world!"
    logger.info("Hello, world!")
    message = server.read(expected_message.bytesize)
    message.should(
      eq(expected_message)
    )
  end
end
