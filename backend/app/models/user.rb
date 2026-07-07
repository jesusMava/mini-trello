# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password


  has_many :owned_workspaces,
            class_name: "Workspace",
            foreign_key: :owner_id,
            dependent: :destroy

  normalizes :email, with: ->(email) { email.strip.downcase }

  validates :first_name,
            presence: true,
            length: { maximum: 100 }

  validates :last_name,
            presence: true,
            length: { maximum: 100 }

  validates :email,
            presence: true,
            uniqueness: true,
            format: URI::MailTo::EMAIL_REGEXP

  validates :password,
            length: { minimum: 8 },
            allow_nil: true
end
