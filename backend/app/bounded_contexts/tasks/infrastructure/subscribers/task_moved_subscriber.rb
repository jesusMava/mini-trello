module Tasks
  module Infrastructure
    module Subscribers
      class TaskMovedSubscriber < Shared::Events::Subscriber
        def call(event)
          TaskMovedJob.perform_async(
            {
              task_id: event.task_id,
              project_id: event.project_id,
              old_position: event.old_position,
              new_position: event.new_position,
              user_id: event.user_id,
              occurred_at: event.occurred_at.iso8601
            }
          )
        end
      end
    end
  end
end
