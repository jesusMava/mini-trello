class AddPublishedAtToOutboxEvent < ActiveRecord::Migration[8.1]
  def change
    add_column :outbox_events, :published_at, :datetime
    add_column :outbox_events, :event_id, :string
    add_index :outbox_events, :event_id, unique: true
    add_index :outbox_events, :processed_at
  end
end
