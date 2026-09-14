class AddLockedAtToOutboxEvents < ActiveRecord::Migration[8.1]
  def change
    add_column :outbox_events, :locked_at, :datetime
  end
end
