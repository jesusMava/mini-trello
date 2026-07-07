# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :register,
          mutation: Identity::GraphQL::Mutations::RegisterMutation
    field :login,
          mutation: Identity::GraphQL::Mutations::LoginMutation
    field :create_workspace,
          mutation: Workspaces::GraphQL::Mutations::CreateWorkspaceMutation
    field :create_project,
          mutation: Projects::GraphQL::Mutations::CreateProjectMutation
    field :create_task,
          mutation: Tasks::GraphQL::Mutations::CreateTaskMutation
    field :move_task,
          mutation: Tasks::GraphQL::Mutations::MoveTaskMutation
  end
end
