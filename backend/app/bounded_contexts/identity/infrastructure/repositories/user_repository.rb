module Identity
  module Infrastructure
    module Repositories
      class UserRepository < Shared::Infrastructure::Repositories::BaseRepository
        def create(attributes)
          User.create!(attributes)
        end

        def find_by_email(email)
          User.find_by(email: email.downcase)
        end

        def find_by_id(id)
          User.find_by(id: id)
        end

        def exists_by_email?(email)
          User.exists?(email: email.downcase)
        end

        def authenticate(email, password)
          user = find_by_email(email)
          return nil unless user

          user.authenticate(password) ? user : nil
        end
      end
    end
  end
end
