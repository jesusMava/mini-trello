# frozen_string_literal: true

module Shared
  module Events
    class EventBus
      def initialize(registry:, publisher:)
        @registry = registry
        @publisher = publisher
      end

      def publish(event)
        envelope = EventEnvelopeFactory.call(event)

        publish_locally(event, envelope)

        publisher.publish(envelope)

        envelope
      end

      private

      attr_reader :registry,
                  :publisher

      def publish_locally(event, envelope)
        registry
          .subscribers_for(event.class)
          .each do |subscriber|
            subscriber.call(event, envelope)
          end
      end
    end
  end
end