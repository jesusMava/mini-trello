class Workspace < ApplicationRecord
  before_validation :normalize_name

  belongs_to :owner,
             class_name: "User"

  has_many :projects,
            dependent: :destroy

  validates :name,
            presence: true,
            length: { maximum: 120 },
            uniqueness: {
              scope: :owner_id,
              case_sensitive: false,
              message: "current user already has a workspace with this name"
            }

  private

  def normalize_name
    self.name = name.strip.capitalize if name.present?
  end
end
