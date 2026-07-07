FactoryBot.define do
  factory :user do
    first_name { "Jesus" }
    last_name { "Mava" }
    sequence(:email) { |n| "user#{n}@example.com" }
    password { "Password123" }
  end
end
