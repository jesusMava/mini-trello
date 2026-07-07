module Projects
  module Application
    module Dto
      class CreateProjectRequest
        attr_reader :name,
                    :workspace_id,
                    :owner_id

        def initialize(name:, workspace_id:, owner_id:)
          @name = name
          @workspace_id = workspace_id
          @owner_id = owner_id
        end
      end
    end
  end
end
