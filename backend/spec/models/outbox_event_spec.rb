require "rails_helper"

RSpec.describe OutboxEvent, type: :model do
  subject(:outbox_event) do
    build(
      :outbox_event,
      event_id: SecureRandom.uuid
    )
  end

  it "is valid with valid attributes" do
    expect(outbox_event).to be_valid
  end

  it "requires a unique event_id" do
    create(
      :outbox_event,
      event_id: outbox_event.event_id
    )

    expect(outbox_event).not_to be_valid
  end
end