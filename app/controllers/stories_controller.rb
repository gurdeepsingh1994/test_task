class StoriesController < ApplicationController
  require 'nokogiri'
  require 'open-uri'

  def show
    story = Story.find_by_id(params[:id])
    if story.present?
      render json: {story: story.as_json(except: [:created_at, :updated_at]).merge(
        updated_time: story.updated_at.to_s,
        images: story.images.as_json(
          except: [:id, :created_at, :updated_at, :story_id ]
          )
        )}, status: 200
    else
      render json: {error: "Story not found with given unique id."}, status: 400
    end
  end

  def create
    begin
      url = params["url"]
      raise "url not present" if url.blank?
      input_url = InputUrl.find_by_url(params["url"])
      if input_url.present?
        story = input_url.story
      else
        canonical_url = ScrapeDataCreator.get_canonical_url(url)
        story = Story.find_by_canonical_url(canonical_url)
        if story.present?
          InputUrl.create(url: url, story: story )
        else
          story = Story.create(canonical_url: canonical_url, scrape_status: "pending")
          InputUrl.create(url: url, story: story )
          ScrapeUrlJob.perform_later(story)
        end
      end
      render json: {story_id: story.id}, status: 200
    rescue => e
      render json: {error: e.message}, status: 400
    end
  end

  private

    # def get_canonical_url(url)
    #   page = Nokogiri::HTML(open(url))
    #   canonical_url = page.search("link[rel='canonical']").first.try(:[], "href")
    #   og_url = page.search("meta[property='og:url']").first.try(:[], "content")
    #   canonical_url || og_url || url
    # end
end
