module Identity
  module Application
    module UseCases
      class Login
        def initialize(
          repository: Identity::Infrastructure::Repositories::UserRepository.new,
          encoder: Identity::Infrastructure::Authentication::JwtEncoder
        )
          @repository = repository
          @encoder = encoder
        end

        def call(request)
          user = @repository.authenticate(
            request.email,
            request.password
          )

          unless user
            return Dto::LoginResponse.failure(
              "Invalid email or password"
            )
          end

          token = @encoder.call(user)

          Dto::LoginResponse.success(
            user: user,
            token: token
          )
        end
      end
    end
  end
end
