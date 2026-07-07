module Workspaces
  module Application
    module Dto
      class CreateWorkspaceResponse
        attr_reader :workspace,
                    :errors

        def initialize(workspace:, errors: [])
          @workspace = workspace
          @errors = errors
        end

        def success?
          errors.empty?
        end

        def failure?
          !success?
        end

        def self.success(workspace)
          new(
            workspace: workspace
          )
        end

        def self.failure(errors)
          new(
            workspace: nil,
            errors: Array(errors)
          )
        end
      end
    end
  end
end
