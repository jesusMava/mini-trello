module Workspaces
  module GraphQL
    module Mutations
      class CreateWorkspaceMutation < ::Mutations::BaseMutation
        graphql_name "CreateWorkspace"

        argument :name, String, required: true

        field :workspace,
              Workspaces::GraphQL::Types::WorkspaceType,
              null: true
        field :errors, [ String ], null: false

        def resolve(name:)
          owner = require_current_user!
          request =
            Workspaces::Application::Dto::CreateWorkspaceRequest.new(
              name: name,
              owner: owner
            )

          result =
            Workspaces::Application::UseCases::CreateWorkspace
              .new
              .call(request)

          {
            workspace: result.workspace,
            errors: result.errors
          }
        end
      end
    end
  end
end
