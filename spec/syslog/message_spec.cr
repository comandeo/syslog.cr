require "../spec_helper"

describe Syslog::Message do
  it "creates well formed message" do
    io = StringIO.new
    message = Syslog::Message.new(
      Syslog::Facility::KERNEL,
      Syslog::Severity::ALERT,
      "timestamp",
      "hostname",
      "appname",
      "message"
    )
    message.to_s(io)
    io.to_s.should eq("<01>timestamp hostname appname [#{Process.pid}]: [ALERT] message")
  end
end
