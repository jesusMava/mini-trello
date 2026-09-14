module Shared
  module Events
    class SnapshotFactory
      def build_task(snapshot)
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
