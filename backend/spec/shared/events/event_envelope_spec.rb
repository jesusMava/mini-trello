require "rails_helper"

RSpec.describe Shared::Events::EventEnvelope do
  subject(:envelope) do
    described_class.new(
      event_id: "event-123",
      event_type: "task.moved",
      version: 1,
      occurred_at: Time.utc(2026, 8, 18, 18, 0, 0),
      producer: "projectflow-tasks",
      aggregate_type: "Task",
      aggregate_id: "15",
      data: {
        project_id: "3",
        old_position: 2,
        new_position: 5
      }
    )
  end

  it "stores event metadata" do
    expect(envelope.event_id).to eq("event-123")
    expect(envelope.event_type).to eq("task.moved")
    expect(envelope.version).to eq(1)
    expect(envelope.producer).to eq("projectflow-tasks")
  end

  it "stores aggregate information" do
    expect(envelope.aggregate_type).to eq("Task")
    expect(envelope.aggregate_id).to eq("15")
  end

  it "converts the envelope to a hash" do
    expect(envelope.to_h).to include(
      event_id: "event-123",
      event_type: "task.moved",
      version: 1,
      producer: "projectflow-tasks"
    )
  end

  it "contains aggregate metadata" do
    expect(envelope.to_h[:aggregate]).to eq(
      type: "Task",
      id: "15"
    )
  end
end