# frozen_string_literal: true

module Shared
  module Events
    class EventEnvelope
      attr_reader :event_type,
                  :aggregate_type,
                  :aggregate_id,
                  :payload

      def initialize(
        event_type:,
        aggregate_type:,
        aggregate_id:,
        payload:
      )
        @event_type = event_type
        @aggregate_type = aggregate_type
        @aggregate_id = aggregate_id
        @payload = payload
      end

      def to_h
        {
          event_type: event_type,
          aggregate_type: aggregate_type,
          aggregate_id: aggregate_id,
          payload: payload
        }
      end
    end
  end
end