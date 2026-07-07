module Identity
  module Application
    module Dto
      class LoginResponse
        attr_reader :user, :token, :errors

        def initialize(user:, token:, errors: [])
          @user = user
          @token = token
          @errors = errors
        end

        def success?
          errors.empty?
        end

        def failure?
          !success?
        end

        def self.success(user:, token:)
          new(
            user: user,
            token: token
          )
        end

        def self.failure(errors)
          new(
            user: nil,
            token: nil,
            errors: Array(errors)
          )
        end
      end
    end
  end
end
