module Graphql
  module Concerns
    module Authentication
      private

      def current_user
        context[:current_user]
      end

      def authenticate!
        raise GraphQL::ExecutionError, "Unauthorized" unless current_user
      end

      def require_current_user!
        authenticate!
        current_user
      end
    end
  end
end