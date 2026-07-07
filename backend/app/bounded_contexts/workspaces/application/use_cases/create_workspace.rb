module Workspaces
  module Application
    module UseCases
      class CreateWorkspace < Shared::Application::ApplicationUseCase
        def initialize(
          repository: Container.workspace_repository
        )
          @repository = repository
        end

        def call(request)
          workspace =
            @repository.create(
              name: request.name,
              owner: request.owner
            )

          Dto::CreateWorkspaceResponse.success(workspace)

        rescue ActiveRecord::RecordInvalid => e
          Dto::CreateWorkspaceResponse.failure(
            e.record.errors.full_messages
          )
        end
      end
    end
  end
end
