class Project < ApplicationRecord
  belongs_to :workspace

  has_many :tasks,
            dependent: :destroy

  validates :name,
            presence: true,
            length: { minimum: 10, maximum: 120 },
            uniqueness: {
              scope: :workspace_id,
              case_sensitive: false,
              message: "Project already exists"
            }
end
