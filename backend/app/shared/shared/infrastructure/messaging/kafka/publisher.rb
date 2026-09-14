# frozen_string_literal: true

module Shared
  module Infrastructure
    module Messaging
      module Kafka
        class Publisher
          TOPIC = "projectflow.events"

          def initialize(kafka:)
            @kafka = kafka
          end

          def publish(outbox_event)
            producer.produce(
              message(outbox_event),
              topic: TOPIC,
              key: outbox_event.aggregate_id.to_s
            )

            producer.deliver_messages
          end

          private

          attr_reader :kafka

          def producer
            @producer ||= kafka.producer
          end

          def message(outbox_event)
            {
              event_id: outbox_event.event_id,
              event_type: outbox_event.event_type,
              aggregate_type: outbox_event.aggregate_type,
              aggregate_id: outbox_event.aggregate_id,
              payload: outbox_event.payload
            }.to_json
          end
        end
      end
    end
  end
end