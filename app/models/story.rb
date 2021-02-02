#["id", "url", "canonical_url", "type", "title", "scrape_status", "created_at", "updated_at"]
class Story < ApplicationRecord
  has_many :images
  enum scrape_status: [:pending, :error, :done]
end
