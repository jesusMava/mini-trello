# frozen_string_literal: true

module Tasks
  module Application
    module UseCases
      class MoveTask
        def initialize(
          task_repository: Container.task_repository,
          position_manager: Container.task_position_manager,
          snapshot_builder: Tasks::Domain::Services::TaskSnapshotBuilder.new,
          outbox_event_repository: Container.outbox_event_repository
        )
          @task_repository = task_repository
          @position_manager = position_manager
          @snapshot_builder = snapshot_builder
          @outbox_event_repository = outbox_event_repository
        end

        def call(request)
          task = load_task(request)

          return task_not_found unless task

          ActiveRecord::Base.transaction do
            old_position = task.position

            move_task(
              task: task,
              new_position: request.new_position
            )

            event = build_task_moved(
              task: task,
              old_position: old_position,
              new_position: request.new_position
            )

            envelope =
              Shared::Events::EventEnvelopeFactory.call(event)

            @outbox_event_repository.create!(
              envelope: envelope
            )
          end

          Dto::MoveTaskResponse.new(
            task: task,
            errors: []
          )

        rescue ActiveRecord::StaleObjectError
          Dto::MoveTaskResponse.new(
            task: nil,
            errors: [
              "Task was modified by another request"
            ]
          )

        rescue ActiveRecord::RecordInvalid => e
          Dto::MoveTaskResponse.new(
            task: nil,
            errors: e.record.errors.full_messages
          )
        end

        private

        attr_reader :task_repository,
                    :position_manager,
                    :snapshot_builder,
                    :outbox_event_repository

        def load_task(request)
          task_repository.find_accessible_by_owner(
            project_id: request.project_id,
            task_id: request.task_id,
            owner_id: request.owner_id
          )
        end

        def move_task(task:, new_position:)
          position_manager.move(
            task: task,
            new_position: new_position
          )
        end

        def build_task_moved(
          task:,
          old_position:,
          new_position:
        )
          Tasks::Application::Events::TaskMoved.new(
            task_id: task.id,
            project_id: task.project_id,
            old_position: old_position,
            new_position: new_position,
            snapshot: snapshot_builder.call(task)
          )
        end

        def task_not_found
          Dto::MoveTaskResponse.new(
            task: nil,
            errors: [
              "Task not found or access denied"
            ]
          )
        end
      end
    end
  end
end
