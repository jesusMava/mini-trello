# frozen_string_literal: true

Rails.application.config.to_prepare do
  Shared::Events::SubscriberRegistry.register!(Container.registry)
end