# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :health_check, String, null: false

    def health_check
      "ProjectFlow API running"
    end

    field :me, resolver: Identity::GraphQL::Resolvers::MeResolver
  end
end
