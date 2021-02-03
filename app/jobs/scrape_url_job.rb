class ScrapeUrlJob < ApplicationJob
  queue_as :default
  require 'nokogiri'
  require 'open-uri'

  def perform(story)
    begin
      scrape_data = ScrapeDataCreator.get_data(story.canonical_url)

      story.title = scrape_data[:title]
      story.og_type = scrape_data[:type]
      story.scrape_status = "done"
      story.save!
      images_data = scrape_data[:images_data]

      images_data.each do |obj|
        if (obj['property'] == "og:image")
          @image.save if @image.present?
          @image = story.images.new( url: obj['content'] )
        elsif (obj['property'] == "og:image:width")
          @image.width = obj['content']
        elsif (obj['property'] == "og:image:height")
          @image.height = obj['content']
        elsif (obj['property'] == "og:image:alt")
          @image.alt = obj['content']
        elsif (obj['property'] == "og:image:type")
          @image.image_type = obj['content']
        end
      end
      @image.save if @image.present?
    rescue
      story.update(scrape_status: "error")
    end
  end
end
