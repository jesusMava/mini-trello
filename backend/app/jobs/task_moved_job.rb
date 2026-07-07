# frozen_string_literal: true

class TaskMovedJob < ApplicationJob
  sidekiq_options queue: :default

  def perform(payload)
    Rails.logger.info(
      {
        event: "task_moved",
        task_id: payload["task_id"],
        old_position: payload["old_position"],
        new_position: payload["new_position"],
        user_id: payload["user_id"]
      }.to_json
    )
  end
end
