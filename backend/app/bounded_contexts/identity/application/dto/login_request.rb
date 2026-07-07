module Identity
  module Application
    module Dto
      class LoginRequest
        attr_reader :email, :password

        def initialize(email:, password:)
          @email = email
          @password = password
        end
      end
    end
  end
end
