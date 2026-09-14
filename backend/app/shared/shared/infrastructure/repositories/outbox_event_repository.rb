# frozen_string_literal: true

module Shared
  module Infrastructure
    module Repositories
      class OutboxEventRepository
        DEFAULT_BATCH_SIZE = 100
        LOCK_TIMEOUT = 5.minutes

        def create!(envelope:)
          OutboxEvent.create!(
            event_id: envelope.event_id,
            event_type: envelope.event_type,
            aggregate_type: envelope.aggregate_type,
            aggregate_id: envelope.aggregate_id,
            payload: envelope.payload,
            status: :pending
          )
        end

        def pending(limit: DEFAULT_BATCH_SIZE)
          OutboxEvent
            .pending
            .where(
              "locked_at IS NULL OR locked_at < ?",
              LOCK_TIMEOUT.ago
            )
            .order(:id)
            .limit(limit)
        end

        def mark_published!(event)
          event.update!(
            status: :published,
            published_at: Time.current,
            locked_at: nil,
            last_error: nil
          )
        end

        def mark_failed!(event, error:)
          event.update!(
            status: :failed,
            attempts: event.attempts + 1,
            locked_at: nil,
            last_error: error
          )
        end
      end
    end
  end
end
