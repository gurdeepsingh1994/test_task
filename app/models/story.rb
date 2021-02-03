#["id", "url", "canonical_url", "og_type", "title", "scrape_status", "created_at", "updated_at"]
class Story < ApplicationRecord
  validates :canonical_url, uniqueness: true, presence: true
  has_many :images, dependent: :destroy
  has_many :input_urls, dependent: :destroy
  enum scrape_status: [:pending, :error, :done]
end
