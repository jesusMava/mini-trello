module Projects
  module Application
    module UseCases
      class CreateProject < Shared::Application::ApplicationUseCase
        def initialize(
          workspace_repository: Container.workspace_repository,
          project_repository: Container.project_repository
        )
          @workspace_repository = workspace_repository
          @project_repository = project_repository
        end

        def call(request)
          workspace = @workspace_repository.find_owned_by(
            user_id: request.owner_id,
            workspace_id: request.workspace_id
          )

          unless workspace
            return Dto::CreateProjectResponse.failure(
              "Workspace not found or access denied"
            )
          end

          project = @project_repository.create(
            name: request.name,
            workspace: workspace
          )

          Dto::CreateProjectResponse.success(project)

        rescue ActiveRecord::RecordInvalid => e
          Dto::CreateProjectResponse.failure(
            errors: e.record.errors.full_messages
          )
        end
      end
    end
  end
end
