module Projects
  module GraphQL
    module Types
      class ProjectType < ::Types::BaseObject
        graphql_name "Project"

        field :id, ID, null: false
        field :name, String, null: false
        field :workspace,
              Workspaces::GraphQL::Types::WorkspaceType,
              null: false
      end
    end
  end
end
