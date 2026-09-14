module Tasks
  module Domain
    module Entities
      class TaskSnapshot
        attr_reader :id,
                    :title,
                    :description,
                    :status,
                    :position,
                    :project_id

        def initialize(
          id:,
          title:,
          description:,
          status:,
          position:,
          project_id:
        )
          @id = id
          @title = title
          @description = description
          @status = status
          @position = position
          @project_id = project_id
        end
      end
    end
  end
end