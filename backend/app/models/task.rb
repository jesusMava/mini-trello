class Task < ApplicationRecord
  belongs_to :project

  enum :status,
    {
      todo: 0,
      in_progress: 1,
      done: 2
    },
    default: :todo,
    suffix: true

  validates :title,
            presence: true,
            length: { maximum: 255 },
            uniqueness: {
              scope: :project_id,
              case_sensitive: false,
              message: "Task already exists"
            }

  validates :position,
            presence: true

  private

  def normalize_title
    self.title = title.strip.capitalize if title.present?
  end
end
