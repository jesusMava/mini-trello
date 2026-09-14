# frozen_string_literal: true

class OutboxEvent < ApplicationRecord
  validates :event_id, presence: true, uniqueness: true
  validates :event_type, presence: true
  validates :aggregate_type, presence: true
  validates :aggregate_id, presence: true
  validates :payload, presence: true

  scope :pending, -> {
    where(published_at: nil)
  }

  scope :published, -> {
    where.not(published_at: nil)
  }
end