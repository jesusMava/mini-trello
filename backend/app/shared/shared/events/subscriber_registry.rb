# frozen_string_literal: true

module Shared
  module Events
    class SubscriberRegistry
      def self.register!(registry)
        subscriptions.each do |event_class_name, subscriber_class_name|
          event_class = event_class_name.constantize
          subscriber_instance = subscriber_class_name.constantize.new

          registry.subscribe(event_class, subscriber_instance)
        end
      end

      def self.subscriptions
        {
          "Tasks::Application::Events::TaskMoved" => "Tasks::Infrastructure::Subscribers::TaskMovedSubscriber"
        }
      end
    end
  end
end
