# frozen_string_literal: true

module Shared
  module Infrastructure
    module Messaging
      class OutboxPublisher
        def initialize(
          outbox_repository: Container.outbox_event_repository,
          kafka_publisher: Container.kafka_publisher
        )
          @outbox_repository = outbox_repository
          @kafka_publisher = kafka_publisher
        end

        def publish_batch
          events = outbox_repository.claim_batch

          events.each do |event|
            publish(event)
          end

          events.size
        end

        private

        attr_reader :outbox_repository,
                    :kafka_publisher

        def publish(event)
          kafka_publisher.publish(
            event
          )

          outbox_repository.mark_published!(
            event
          )
        rescue StandardError => e
          outbox_repository.mark_failed!(
            event,
            e
          )
        end
      end
    end
  end
end