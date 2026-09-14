# frozen_string_literal: true

module Shared
  module Infrastructure
    module Outbox
      class OutboxPublisher
        def publish(event)
          Rails.logger.info(
            "[OUTBOX] Publishing event=#{event.event_type} id=#{event.id}"
          )
        end
      end
    end
  end
end
