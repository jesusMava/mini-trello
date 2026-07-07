module Tasks
  module Application
    module Dto
      class CreateTaskResponse
        attr_reader :task,
                    :errors

        def initialize(task:, errors: [])
          @task = task
          @errors = errors
        end

        def success?
          errors.empty?
        end
      end
    end
  end
end
