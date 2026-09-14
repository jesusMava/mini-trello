# app/shared/outbox/infrastructure/repositories/outbox_repository.rb

module Shared
  module Outbox
    module Infrastructure
      module Repositories
        class OutboxRepository
          MAX_RETRIES = 5

          def store(message)
            OutboxEvent.create!(
              aggregate_type: message.aggregate_type,
              aggregate_id: message.aggregate_id,
              event_type: message.event_type,
              payload: message.payload
            )
          end

          def claim_pending(limit:)
            OutboxEvent.transaction do
              events =
                pending_scope(limit)
              events.each do |event|
                claim(event)
              end
              events
            end

          end

          def mark_sent(event)
            event.update!(
              status: :sent,
              processed_at: Time.current
            )
          end

          def mark_failed(event, error)
            if event.attempts >= MAX_RETRIES

              event.update!(
                status: :dead_letter,
                last_error: error,
              )
            else
              event.update!(
                status: :pending,
                last_error: error,
              )
            end

          def mark_processing(event)
            event.update!(
              status: :processing,
              attempts: event.attempts + 1
            )
          end

          private

          def pending_scope(limit)
            OutboxEvent
              .pending
              .order(:created_at)
              .limit(limit)
              .lock("FOR UPDATE SKIP LOCKED")
          end

          def claim(event)
            event.update!(
              status: :processing,
              attempts: event.attempts + 1
            )
          end
        end
      end
    end
  end
end
