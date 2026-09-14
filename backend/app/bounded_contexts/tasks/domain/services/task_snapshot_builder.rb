module Tasks
  module Domain
    module Services
      class TaskSnapshotBuilder
        def call(task)
          {
            id: task.id,
            title: task.title,
            description: task.description,
            status: task.status,
            position: task.position,
            project_id: task.project_id
          }
        end
      end
    end
  end
end