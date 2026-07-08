module Tasks
  module Application
    module UseCases
      class ListTasks
        def initialize(
          task_repository: Container.task_repository
        )
          @task_repository = task_repository
        end

        def call(request)
          tasks = @task_repository.all_by_project(
            project_id: request.project_id
          )

          Dto::ListTasksResponse.success(tasks)
        rescue ActiveRecord::RecordInvalid => e
          Dto::ListTasksResponse.new(
            e.record.errors.full_messages
          )
        end
      end
    end
  end
end