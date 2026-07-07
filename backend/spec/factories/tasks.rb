FactoryBot.define do
  factory :task do
    sequence(:title) { |n| "Task #{n}" }
    description { "Description" }
    status { :todo }
    sequence(:position) { |n| n }
    association :project
  end
end
