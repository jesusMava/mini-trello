module Identity
  module Infrastructure
    module Authentication
      class JwtDecoder
        def self.call(token)
          JWT.decode(
            token,
            ENV.fetch("JWT_SECRET_KEY"),
            true,
            algorithm: "HS256"
          ).first
        end
      end
    end
  end
end
