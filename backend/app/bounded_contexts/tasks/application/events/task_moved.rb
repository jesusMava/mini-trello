# frozen_string_literal: true

module Tasks
  module Application
    module Events
      class TaskMoved < Shared::Events::Event
        attr_reader :task_id,
                    :project_id,
                    :old_position,
                    :new_position,
                    :user_id,
                    :occurred_at

        def initialize(
          task_id:,
          project_id:,
          old_position:,
          new_position:,
          user_id:
        )
          @task_id = task_id
          @project_id = project_id
          @old_position = old_position
          @new_position = new_position
          @user_id = user_id
          @occurred_at = Time.current
        end
      end
    end
  end
end
