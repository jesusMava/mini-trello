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
        registry: registry,
        publisher: kafka_publisher
      )
  end

  def outbox_repository
    @outbox_repository ||=
    Shared::Outbox::Infrastructure::Repositories::OutboxRepository.new
  end

  def self.outbox_event_repository
    @outbox_event_repository ||=
      Shared::Infrastructure::Repositories::OutboxEventRepository.new
  end

  def self.kafka
    @kafka ||= Kafka.new(
      seed_brokers: [
        ENV.fetch(
          "KAFKA_BROKERS",
          "kafka:9092"
        )
      ],
      client_id: "projectflow"
    )
  end

  def self.kafka_publisher
    @kafka_publisher ||=
      Shared::Infrastructure::Messaging::Kafka::Publisher.new(
        kafka: kafka
      )
  end

  def self.outbox_publisher
    @outbox_publisher ||=
      Shared::Infrastructure::Messaging::OutboxPublisher.new
  end

  def self.outbox_dispatcher
    @outbox_dispatcher ||= Shared::Infrastructure::Outbox::OutboxDispatcher.new
  end
end
