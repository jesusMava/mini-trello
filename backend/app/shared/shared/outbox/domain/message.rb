module Shared
  module Outbox
    module Domain
      class Message

        attr_reader :aggregate_type,
                    :aggregate_id,
                    :event_type,
                    :payload

        def initialize(
          aggregate_type:,
          aggregate_id:,
          event_type:,
          payload:
        )
          @aggregate_type = aggregate_type
          @aggregate_id = aggregate_id
          @event_type = event_type
          @payload = payload
        end
      end
    end
  end
end
