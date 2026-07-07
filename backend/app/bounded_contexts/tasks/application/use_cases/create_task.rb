module Tasks
  module Application
    module UseCases
      class CreateTask
        def initialize(
          project_repository: Projects::Infrastructure::Repositories::ProjectRepository.new,
          task_repository: Tasks::Infrastructure::Repositories::TaskRepository.new
        )
          @project_repository = project_repository
          @task_repository = task_repository
        end

        def call(request)
          project = load_project(request)

          return project_not_found unless project

          task = @task_repository.create(
            title: request.title,
            description: request.description,
            project: project
          )

          Dto::CreateTaskResponse.new(
            task: task
          )

        rescue ActiveRecord::RecordInvalid => e
          Dto::CreateTaskResponse.new(
            task: nil,
            errors: e.record.errors.full_messages
          )
        end

        private

        def load_project(request)
          @project_repository.find_accessible_by_owner(
            project_id: request.project_id,
            owner_id: request.owner_id
          )
        end

        def project_not_found
          Dto::CreateTaskResponse.new(
            task: nil,
            errors: [
              "Project not found or access denied"
            ]
          )
        end
      end
    end
  end
end