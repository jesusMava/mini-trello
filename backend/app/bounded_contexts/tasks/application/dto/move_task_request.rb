module Tasks
  module Application
    module Dto
      class MoveTaskRequest
        attr_reader :project_id,
                    :task_id,
                    :owner_id,
                    :new_position

        def initialize(
          project_id:,
          task_id:,
          owner_id:,
          new_position:
        )
          @project_id = project_id
          @task_id = task_id
          @owner_id = owner_id
          @new_position = new_position
        end
      end
    end
  end
end
