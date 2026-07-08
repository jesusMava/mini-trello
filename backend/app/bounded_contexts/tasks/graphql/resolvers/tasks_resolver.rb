module Tasks
  module GraphQL
    module Resolvers
      class TasksResolver < ::Resolvers::BaseResolver
        type [ Tasks::GraphQL::Types::TaskType ],
          null: false

        argument :project_id, ID, required: true

        def resolve(project_id:)
          owner = require_current_user!

          request =
            Tasks::Application::Dto::ListTasksRequest.new(
              project_id: project_id,
              owner_id: owner.id
            )

          result =
            Tasks::Application::UseCases::ListTasks
              .new
              .call(request)

          result.tasks
        end
      end
    end
  end
end
