module Projects
  module GraphQL
    module Mutations
      class CreateProjectMutation < ::Mutations::BaseMutation
        graphql_name "CreateProject"

        argument :name, String, required: true
        argument :workspace_id, ID, required: true

        field :project,
              Projects::GraphQL::Types::ProjectType,
              null: true
        field :errors, [ String ], null: false

        def resolve(name:, workspace_id:)
          owner = require_current_user!

          request = Application::Dto::CreateProjectRequest.new(
            name: name,
            workspace_id: workspace_id,
            owner_id: owner.id
          )

          result = Application::UseCases::CreateProject
                   .new
                   .call(request)

          {
            project: result.project,
            errors: result.errors
          }
        end
      end
    end
  end
end
