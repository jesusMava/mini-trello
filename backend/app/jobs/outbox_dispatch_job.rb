
# frozen_string_literal: true

class OutboxDispatchJob < ApplicationJob
  queue_as :default

  def perform
    Container.outbox_dispatcher.call
  end
end
