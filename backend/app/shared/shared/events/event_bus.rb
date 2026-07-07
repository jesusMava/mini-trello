# frozen_string_literal: true

module Shared
  module Events
    class EventBus
      def initialize(registry:)
        @registry = registry
      end

      def publish(event)
        registry
          .subscribers_for(event.class)
          .each do |subscriber|
            subscriber.call(event)
          end
      end

      private

      attr_reader :registry
    end
  end
end
