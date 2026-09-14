# frozen_string_literal: true

require "securerandom"

module Shared
  module Events
    class EventEnvelopeFactory
      def self.call(event)
        new(event).call
      end

      def initialize(event)
        @event = event
      end

      def call
        EventEnvelope.new(
          event_id: SecureRandom.uuid,
          event_type: event.class.name,
          aggregate_type: aggregate_type,
          aggregate_id: aggregate_id,
          payload: event_payload
        )
      end

      private

      attr_reader :event

      def aggregate_type
        "Task"
      end

      def aggregate_id
        event.task_id
      end

      def event_payload
        event.to_h
      end
    end
  end
end