#["id", "url", "canonical_url", "og_type", "title", "scrape_status", "created_at", "updated_at"]
class Story < ApplicationRecord
  has_many :images, dependent: :destroy
  enum scrape_status: [:pending, :error, :done]
end
