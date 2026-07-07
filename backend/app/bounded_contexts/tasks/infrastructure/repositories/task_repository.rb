module Tasks
  module Infrastructure
    module Repositories
      class TaskRepository
        def create(title:, description:, project:)
          Task.create!(
            title: title,
            description: description,
            status: :todo,
            position: next_position(project),
            project: project
          )
        end

        def update_position(task:, position:)
          task.update!(position: position)
        end

        def shift_up(project:, from:, to:)
          project
            .tasks
            .where(position: from..to)
            .order(:position)
            .each do |other|
              other.position += 1
              task_repository.save(other)
            end
        end

        def shift_down(project:, from:, to:)
          project
            .tasks
            .where(position: from..to)
            .order(position: :desc)
            .each do |other|
              other.position -= 1
              task_repository.save(other)
            end
        end

        def save(task)
          task.save!
        end

        def tasks_between(project:, from:, to:)
          project
            .tasks
            .where(position: from..to)
            .order(:position)
        end

        def find_accessible_by_owner(task_id:, owner_id:)
            Task
            .joins(project: :workspace)
            .find_by(
              id: task_id,
              workspaces: {
                owner_id: owner_id
              }
            )
        end

        private

        def next_position(project)
          project.tasks.maximum(:position).to_i + 1
        end
      end
    end
  end
end
