module Identity
  module GraphQL
    module Mutations
      class LoginMutation < ::Mutations::BaseMutation
        graphql_name "Login"

        argument :email, String, required: true
        argument :password, String, required: true

        field :token, String, null: true
        field :user, Identity::GraphQL::Types::UserType, null: true
        field :errors, [ String ], null: false

        def resolve(email:, password:)
          request = Identity::Application::Dto::LoginRequest.new(
            email: email,
            password: password
          )

          result = Identity::Application::UseCases::Login
                     .new
                     .call(request)

          {
            token: result.token,
            user: result.user,
            errors: result.errors
          }
        end
      end
    end
  end
end