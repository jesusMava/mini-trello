module Workspaces
  module Infrastructure
    module Repositories
      class WorkspaceRepository < Shared::Infrastructure::Repositories::BaseRepository
        def create(attributes)
          Workspace.create!(attributes)
        end

        def find(id)
          Workspace.find(id)
        end

        def find_owned_by(user_id:, workspace_id:)
          Workspace.find_by(
            id: workspace_id,
            owner_id: user_id
          )
        end
      end
    end
  end
end
