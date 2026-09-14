module Shared
  module Outbox
    class Processor
      def initialize(
        repository: Container.outbox_repository,
        event_bus: Container.event_bus
      )
        @repository = repository
        @event_bus = event_bus
      end

      def call
        repository.pending.each do |record|
          publish(record)
        end
      end

      private

      attr_reader :repository,
                  :event_bus

      def publish(record)
      end
    end
  end
end
