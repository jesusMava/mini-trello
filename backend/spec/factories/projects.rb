FactoryBot.define do
  factory :project do
    sequence(:name) { |n| "Proyecto #{n}" }
    association :workspace # Crea un workspace automáticamente al crear un proyecto
  end
end