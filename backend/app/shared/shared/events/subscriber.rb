module Shared
  module Events
    class Subscriber
      def call(_event)
        raise NotImplementedError,
              "#{self.class} must implement #call"
      end
    end
  end
end
