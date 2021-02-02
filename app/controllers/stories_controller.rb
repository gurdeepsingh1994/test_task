class StoriesController < ApplicationController

  def show
    story = Story.find_by_id(params[:id])
    if story.present?
      render json: {story: story.as_json.merge(
        images: story.images.as_json(
          except: [:id, :created_at, :updated_at, :story_id ]
          )
        )}, status: 200
    else
      render json: {error: "There is not any story with given uniqe id."}, status: 400
    end
  end

  def create
    begin
      url = params["url"]
      raise "url not present" if url.blank?
      story = Story.find_by_url(params["url"])
      if !story
        story = Story.create(url: url, scrape_status: "pending")
        ScrapeUrlJob.perform_later(story)
      end
      render json: {story_id: story.id}, status: 200
    rescue => e
      render json: {error: e}, status: 400
    end
  end

  private
    def story_params
      params.require(:story).permit(:url, :canonical_url, :type, :title, :scrape_status)
    end
end
