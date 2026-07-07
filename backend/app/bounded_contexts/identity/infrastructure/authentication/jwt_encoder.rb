module Identity
  module Infrastructure
    module Authentication
      class JwtEncoder
        def self.call(user)
          payload = {
            sub: user.id,
            email: user.email,
            exp: 24.hours.from_now.to_i
          }

          JWT.encode(
            payload,
            ENV.fetch("JWT_SECRET_KEY"),
            "HS256"
          )
        end
      end
    end
  end
end
