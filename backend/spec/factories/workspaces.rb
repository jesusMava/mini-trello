FactoryBot.define do
  factory :workspace do
    sequence(:name) { |n| "Workspace #{n}" }
    association :owner, factory: :user 
  end
end
