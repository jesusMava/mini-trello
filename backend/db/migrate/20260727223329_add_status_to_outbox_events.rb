class AddStatusToOutboxEvents < ActiveRecord::Migration[8.1]
  def change
    add_column :outbox_events, :attempts, :integer, default: 0, null: false
    add_column :outbox_events, :last_error, :text

  end
end
