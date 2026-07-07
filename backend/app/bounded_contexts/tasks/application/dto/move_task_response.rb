module Tasks
  module Application
    module Dto
      class MoveTaskResponse
        attr_reader :task,
                    :errors

        def initialize(task:, errors: [])
          @task = task
          @errors = errors
        end

        def success?
          errors.empty?
        end

        def failure?
          !success?
        end

        def self.success(task)
          new(task: task)
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
