# frozen_string_literal: true

module Identity
  module GraphQL
    module Mutations
      class RegisterMutation < ::Mutations::BaseMutation
        graphql_name "Register"

        argument :first_name, String, required: true
        argument :last_name, String, required: true
        argument :email, String, required: true
        argument :password, String, required: true

        field :user,
              Identity::GraphQL::Types::UserType,
              null: true
        field :errors, [ String ], null: false

        def resolve(**attributes)
          request =
            Identity::Application::Dto::RegisterRequest.new(
              **attributes
            )

          result =
            Identity::Application::UseCases::RegisterUser.call(request)

          {
            user: result.user,
            errors: result.errors
          }
        end
      end
    end
  end
end
