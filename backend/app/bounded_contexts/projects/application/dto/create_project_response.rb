module Projects
  module Application
    module Dto
      class CreateProjectResponse
        attr_reader :project,
                    :errors

        def initialize(project:, errors: [])
          @project = project
          @errors = errors
        end

        def success?
          errors.empty?
        end

        def failure?
          !success?
        end

        def self.success(project)
          new(
            project: project
          )
        end

        def self.failure(errors)
          new(
            project: nil,
            errors: Array(errors)
          )
        end
      end
    end
  end
end
