# frozen_string_literal: true

module Tasks
  module GraphQL
    module Mutations
      class MoveTaskMutation < ::Mutations::BaseMutation
        graphql_name "MoveTask"

        argument :task_id, ID, required: true
        argument :new_position, Integer, required: true

        field :task,
              Tasks::GraphQL::Types::TaskType,
              null: true
        field :errors, [ String ], null: false

        def resolve(task_id:, new_position:)
          owner = require_current_user!
          request =
            Tasks::Application::Dto::MoveTaskRequest.new(
              task_id: task_id,
              owner_id: owner.id,
              new_position: new_position
            )

          result =
            Tasks::Application::UseCases::MoveTask
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
