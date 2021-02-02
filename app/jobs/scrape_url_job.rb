class ScrapeUrlJob < ApplicationJob
  queue_as :default
  require 'nokogiri'
  require 'open-uri'

  def perform(story)
    begin
      page = Nokogiri::HTML(open(story.canonical_url))
      story.title = page.search("meta[property='og:title']").first.try(:[], "content")
      story.og_type = page.search("meta[property='og:type']").first.try(:[], "content")
      story.scrape_status = "done"
      story.save

      images_data = page.search(
      "meta[property='og:image'], meta[property='og:image:width'],
      meta[property='og:image:height'], meta[property='og:image:alt'],
      meta[property='og:image:type']")

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
