FactoryBot.define do
  factory :outbox_event do
      event_id { SecureRandom.uuid }
      event_type { "Tasks::Domain::Events::TaskMoved" }
      aggregate_type { "Task" }
      aggregate_id { "1" }

      payload do
        {
          task_id: "1",
          project_id: "1",
          old_position: 1,
          new_position: 2
        }
      end
  end
end
