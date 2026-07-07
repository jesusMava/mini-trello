module Container
  module_function
  
  def workspace_repository
    @workspace_repository ||= Workspaces::Infrastructure::Repositories::WorkspaceRepository.new
  end

  def project_repository
    @project_repository ||= Projects::Infrastructure::Repositories::ProjectRepository.new
  end

  def task_repository
    @task_repository ||= Tasks::Infrastructure::Repositories::TaskRepository.new
  end

  def task_position_manager
    @task_position_manager ||= Tasks::Domain::Services::PositionManager.new(
      task_repository: task_repository
    )
  end

  def registry
    @registry ||= Shared::Events::Registry.new
  end

  def event_bus
    @event_bus ||=
      Shared::Events::EventBus.new(
        registry: registry
      )
  end
end
