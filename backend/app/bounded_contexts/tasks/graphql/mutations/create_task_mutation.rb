module Tasks
  module GraphQL
    module Mutations
      class CreateTaskMutation < ::Mutations::BaseMutation
        graphql_name "CreateTask"

        argument :title, String, required: true
        argument :description, String, required: false
        argument :project_id, ID, required: true


        field :task,
              Tasks::GraphQL::Types::TaskType,
              null: true
        field :errors, [ String ], null: false

        def resolve(**attributes)
          owner = require_current_user!
          request_attributes = attributes.merge(owner_id: owner.id)

          request =
            Tasks::Application::Dto::CreateTaskRequest.new(
              **request_attributes
            )

          result =
            Tasks::Application::UseCase::CreateTask
              .new
              .call(request)

          {
            task: result.task,
            errors: result.errors
          }
        end
      end
    end
  end
end
