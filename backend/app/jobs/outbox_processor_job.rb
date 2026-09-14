class OutboxProcessorJob < ApplicationJob
  include Sidekiq::Job

  sidekiq_options(
    queue: :events,
    retry: 10
  )

  def perform
    Container.outbox_publisher.publish_batch
  end
end
