# frozen_string_literal: true

module Tasks
  module Application
    module Events
      class TaskMoved
        attr_reader :task_id,
                    :project_id,
                    :old_position,
                    :new_position,
                    :snapshot

        def initialize(
          task_id:,
          project_id:,
          old_position:,
          new_position:,
          snapshot:
        )
          @task_id = task_id
          @project_id = project_id
          @old_position = old_position
          @new_position = new_position
          @snapshot = snapshot
        end

        def event_type
          "task.moved"
        end

        def version
          1
        end

        def aggregate_type
          "Task"
        end

        def aggregate_id
          task_id
        end
      end
    end
  end
end