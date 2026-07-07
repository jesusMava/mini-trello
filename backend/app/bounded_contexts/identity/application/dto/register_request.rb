module Identity
  module Application
    module Dto
      class RegisterRequest
        attr_reader :first_name,
                    :last_name,
                    :email,
                    :password

        def initialize(first_name:, last_name:, email:, password:)
          @first_name = first_name
          @last_name = last_name
          @email = email
          @password = password
        end

        def self.from_params(params)
          new(
            first_name: params[:first_name],
            last_name: params[:last_name],
            email: params[:email],
            password: params[:password]
          )
        end
      end
    end
  end
end
