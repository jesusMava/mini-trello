# frozen_string_literal: true

module Resolvers
  class BaseResolver < GraphQL::Schema::Resolver
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
