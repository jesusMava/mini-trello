RSpec.describe Shared::Events::EventBus do
  class FakeSubscriber
    attr_reader :called

    def initialize
      @called = false
    end

    def call(_event)
      @called = true
    end
  end

  it "publishes an event to every subscriber" do
    registry = Shared::Events::Registry.new
    subscriber = FakeSubscriber.new

    registry.subscribe(
      Tasks::Application::Events::TaskMoved,
      subscriber
    )

    event_bus = described_class.new(registry: registry)
    event = Tasks::Application::Events::TaskMoved.new(
        task_id: 10,
        project_id: 100,
        old_position: 1,
        new_position: 2,
        user_id: 1
      )

    event_bus.publish(event)

    expect(subscriber.called).to be(true)
  end
end
