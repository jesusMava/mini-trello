module Identity
  module GraphQL
    module Resolvers
      class MeResolver < ::Resolvers::BaseResolver
        type Identity::GraphQL::Types::UserType, null: true

        def resolve
          authenticate!

          current_user
        end
      end
    end
  end
end
