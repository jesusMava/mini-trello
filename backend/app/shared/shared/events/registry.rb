module Shared
  module Events
    class Registry
      def initialize
        @subscriptions = Hash.new { |hash, key| hash[key] = [] }
      end

      def subscribe(event_class, subscriber)
        @subscriptions[event_class] << subscriber
      end

      def publish(event)
        @subscriptions.fetch(event.class, []).each do |subscriber|
          subscriber.call(event)
        end
      end

      def subscribers_for(event_class)
        @subscriptions[event_class]
      end
    end
  end
end
