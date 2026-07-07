module Tasks
  module Application
    module UseCases
      class MoveTask
        def initialize(
          task_repository: Container.task_repository,
          position_manager: Tasks::Domain::Services::PositionManager.new(
            task_repository: Container.task_repository
          ),
          event_bus: Container.event_bus
        )
          @task_repository = task_repository
          @position_manager = position_manager
          @event_bus = event_bus
        end

        def call(request)
          task = load_task(request)
          return not_found unless task

          old_position = task.position

          position_manager.move(
            task: task,
            new_position: request.new_position
          )

          event =
            Tasks::Application::Events::TaskMoved.new(
              task_id: task.id,
              project_id: task.project_id,
              old_position: old_position,
              new_position: task.position,
              user_id: request.owner_id
          )

          event_bus.publish(event)

          Dto::MoveTaskResponse.success(task)
        rescue ActiveRecord::StaleObjectError
          Dto::MoveTaskResponse.failure(
            "The task was modified by another user. Please reload and try again."
          )
        end

        private

        attr_reader :task_repository,
                    :position_manager,
                    :event_bus

        def load_task(request)
          task_repository.find_accessible_by_owner(
            task_id: request.task_id,
            owner_id: request.owner_id
          )
        end

        def not_found
          Dto::MoveTaskResponse.failure("Task not found")
        end
      end
    end
  end
end
