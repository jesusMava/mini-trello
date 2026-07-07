RSpec.describe Shared::Events::Registry do
  let(:registry) { described_class.new }

  class DummyEvent < Shared::Events::Event; end

  class DummySubscriber
    attr_reader :called

    def initialize
      @called = false
    end

    def call(_event)
      @called = true
    end
  end

  it "publishes an event to registered subscribers" do
    subscriber = DummySubscriber.new

    registry.subscribe(DummyEvent, subscriber)

    registry.publish(DummyEvent.new)

    expect(subscriber.called).to be(true)
  end
end
