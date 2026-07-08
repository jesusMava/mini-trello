module Tasks
  module Application
    module Dto
      class ListTasksRequest
        attr_reader :project_id,
                    :owner_id
                    :errors

        def initialize(project_id:, owner_id:, errors: [])
          @project_id = project_id
          @owner_id = owner_id
          @errors = errors
        end

        def success?
          errors.empty?
        end
      end
    end
  end
end
