#["id", "url", "image_type", "width", "height", "alt", "story_id", "created_at", "updated_at"]
class Image < ApplicationRecord
  belongs_to :story
end
