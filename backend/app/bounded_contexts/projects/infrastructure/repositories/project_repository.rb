module Projects
  module Infrastructure
    module Repositories
      class ProjectRepository < Shared::Infrastructure::Repositories::BaseRepository
        def create(attributes)
          Project.create!(attributes)
        end

        def find(id)
          Project.find(id)
        end

        def find_accessible_by_owner(project_id:, owner_id:)
          Project
            .joins(:workspace)
            .find_by(
              id: project_id,
              workspace: {
                owner_id: owner_id
              }
            )
        end
      end
    end
  end
end
