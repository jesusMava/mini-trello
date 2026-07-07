module Identity
  module Application
    module UseCases
      class RegisterUser < Shared::Application::ApplicationUseCase
        def initialize(repository: Infrastructure::Repositories::UserRepository.new)
          @repository = repository
        end

        def call(request)
          return email_taken if repository.exists_by_email?(request.email)

          user = repository.create(
            first_name: request.first_name,
            last_name: request.last_name,
            email: request.email,
            password: request.password
          )

          Dto::RegisterResponse.success(user)
        rescue ActiveRecord::RecordInvalid => e
          Dto::RegisterResponse.failure(
            errors: e.record.errors.full_messages
          )
        end

        private

        attr_reader :repository

        def email_taken
          Dto::RegisterResponse.failure(
            "Email has already been taken"
          )
        end
      end
    end
  end
end
