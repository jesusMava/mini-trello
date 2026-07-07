# frozen_string_literal: true

module Tasks
  module Domain
    module Services
      class PositionManager
        def initialize(task_repository:)
          @task_repository = task_repository
        end

        def move(task:, new_position:)
          return if task.position == new_position

          new_position = new_position.clamp(1, task.project.tasks.count)

          ActiveRecord::Base.transaction do
            old_position = task.position
            normalize_position!(
              task: task,
              old_position: old_position,
              new_position: new_position
            )

            task.position = new_position
            task_repository.save(task)

            Tasks::Application::Events::TaskMoved.new(
              task_id: task.id,
              project_id: task.project_id,
              old_position: old_position,
              new_position: new_position,
              user_id: nil
            )
          end
        end

        private

        attr_reader :task_repository

        def normalize_position!(task:, old_position:, new_position:)
          new_position < old_position ?
            move_up(task, old_position, new_position) :
            move_down(task, old_position, new_position)
        end

        def move_up(task, old_position, new_position)
          task_repository
            .tasks_between(
              project: task.project,
              from: new_position,
              to: old_position - 1
            )
            .each do |other|
              other.position += 1
              task_repository.save(other)
            end
        end

        def move_down(task, old_position, new_position)
          task_repository
            .tasks_between(
              project: task.project,
              from: old_position + 1,
              to: new_position
            )
            .each do |other|
              other.position -= 1
              task_repository.save(other)
            end
        end
      end
    end
  end
end
