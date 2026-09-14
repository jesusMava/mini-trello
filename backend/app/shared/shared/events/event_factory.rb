module Shared
  module Events
    class EventFactory
      def initialize(snapshot_factory: SnapshotFactory.new)
        @snapshot_factory = snapshot_factory
        @builders = {
          "Tasks::Domain::Events::TaskMoved" =>
            method(:build_task_moved)
        }
      end

      def build(record)
        builder =
          @builders.fetch(record.event_type) do
            raise "Unknown event #{record.event_type}"
          end

        builder.call(record.payload)
      end

      private

      def build_task_moved(payload)
        snapshot = snapshot_factory.build_task(payload["task"])
        # snapshot = build_snapshot(payload["task"])

        Tasks::Domain::Events::TaskMoved.new(
          task: snapshot,
          old_position: payload["old_position"],
          new_position: payload["new_position"],
          user_id: payload["owner_id"]
        )
      end

      def build_snapshot(snapshot)
        Tasks::Domain::Entities::TaskSnapshot.new(
          id: snapshot["id"],
          title: snapshot["title"],
          description: snapshot["description"],
          status: snapshot["status"],
          position: snapshot["position"],
          project_id: snapshot["project_id"]
        )
      end
    end
  end
end
