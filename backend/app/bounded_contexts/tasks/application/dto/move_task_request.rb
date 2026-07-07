module Tasks
  module Application
    module Dto
      class MoveTaskRequest
        attr_reader :task_id,
                    :owner_id,
                    :new_position

        def initialize(
          task_id:,
          owner_id:,
          new_position:
        )
          @task_id = task_id
          @owner_id = owner_id
          @new_position = new_position
        end
      end
    end
  end
end
