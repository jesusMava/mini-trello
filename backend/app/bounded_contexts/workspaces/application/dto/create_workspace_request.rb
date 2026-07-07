module Workspaces
  module Application
    module Dto
      class CreateWorkspaceRequest
        attr_reader :name, :owner

        def initialize(name:, owner:)
          @name = name
          @owner = owner
        end
      end
    end
  end
end
