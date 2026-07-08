module Tasks
  module Application
    module Dto
      class ListTasksResponse
        attr_reader :tasks,
                    :errors

        def initialize(tasks:, errors: [])
          @tasks = tasks
          @errors = errors
        end

        def success?
          errors.empty?
        end

        def failure?
          !success?
        end

        def self.success(tasks)
          new(tasks: tasks)
        end

        def self.failure(errors)
          new(
            task: nil,
            errors: Array(errors)
          )
        end
      end
    end
  end
end
