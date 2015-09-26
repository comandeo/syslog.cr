require "../spec_helper"

describe Syslog::Message do
  it "creates well formed message" do
    io = StringIO.new
    message = Syslog::Message.new(
      Syslog::Facility::KERNEL,
      Syslog::Severity::ALERT,
      "timestamp",
      "hostname",
      "message"
    )
    message.to_s(io)
    io.to_s.should eq("<01> timestamp hostname message")
  end
end
