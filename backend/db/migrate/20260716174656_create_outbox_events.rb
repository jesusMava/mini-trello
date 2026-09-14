class CreateOutboxEvents < ActiveRecord::Migration[8.1]
  def change
    create_table :outbox_events do |t|
      t.string :aggregate_type, null: false
      t.bigint :aggregate_id, null: false
      t.string :event_type, null: false
      t.jsonb :payload, default: {}
      t.integer :status,
                default: 0,
                null: false
      t.datetime :processed_at

      t.timestamps
    end
    add_index :outbox_events, :status
    add_index :outbox_events, :event_type
  end
end
