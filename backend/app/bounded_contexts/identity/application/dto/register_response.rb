module Identity
  module Application
    module Dto
      class RegisterResponse
        attr_reader :user,
                    :errors

        def initialize(user:, errors: [])
          @user = user
          @errors = errors
        end

        def success?
          errors.empty?
        end

        def failure?
          !success?
        end

        def self.success(user)
          new(
            user: user
          )
        end

        def self.failure(errors)
          new(
            user: nil,
            errors: Array(errors)
          )
        end
      end
    end
  end
end
