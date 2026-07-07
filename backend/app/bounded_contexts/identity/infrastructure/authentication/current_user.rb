# frozen_string_literal: true

module Identity
  module Infrastructure
    module Authentication
      class CurrentUser
        def initialize(repository: Identity::Infrastructure::Repositories::UserRepository.new)
          @repository = repository
        end

        def self.call(token, **dependencies)
          new(**dependencies).call(token)
        end

        def call(token)
          payload = JwtDecoder.call(token)
          return nil unless payload

          @repository.find_by_id(payload["sub"])
        rescue JWT::DecodeError,
               JWT::ExpiredSignature,
               JWT::VerificationError
          nil
        end
      end
    end
  end
end
