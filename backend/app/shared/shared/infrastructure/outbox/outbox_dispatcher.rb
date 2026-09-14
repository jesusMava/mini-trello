# frozen_string_literal: true

module Shared
  module Infrastructure
    module Outbox
      class OutboxDispatcher
        BATCH_SIZE = 100

        def initialize(
          outbox_event_repository: Container.outbox_event_repository,
          publisher: Container.outbox_publisher
        )
          @outbox_event_repository = outbox_event_repository
          @publisher = publisher
        end

        def call
          events =
            outbox_event_repository.claim_batch(
              limit: BATCH_SIZE
            )

          events.each do |event|
            publish(event)
          end

          events.size
        end

        private

        attr_reader :outbox_event_repository,
                    :publisher

        def publish(event)
          publisher.publish(event)

          outbox_event_repository.mark_published!(
            event
          )
        rescue StandardError => e
          outbox_event_repository.mark_failed!(
            event,
            error: e.message
          )
        end
      end
    end
  end
end
