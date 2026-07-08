module Tasks
  module GraphQL
    module Types
      class TaskType < ::Types::BaseObject
        graphql_name "Task"

        field :id, ID, null: false
        field :title, String, null: false
        field :description, String, null: true
        field :status, String, null: false
        field :position, Integer, null: false
        field :project,
              Projects::GraphQL::Types::ProjectType,
              null: false
        field :tasks,
              resolver: Tasks::GraphQL::Resolvers::TasksResolver
      end
    end
  end
end
