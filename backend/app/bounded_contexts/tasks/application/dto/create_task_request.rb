module Tasks
  module Application
    module Dto
      class CreateTaskRequest
        attr_reader :title,
                    :description,
                    :project_id,
                    :owner_id

        def initialize(
          title:,
          description:,
          project_id:,
          owner_id:
        )
          @title = title
          @description = description
          @project_id = project_id
          @owner_id = owner_id
        end
      end
    end
  end
end
