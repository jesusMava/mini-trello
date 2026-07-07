module Workspaces
  module GraphQL
    module Types
      class WorkspaceType < ::Types::BaseObject
        graphql_name "Workspace"

        field :id, ID, null: false
        field :name, String, null: false
      end
    end
  end
end
