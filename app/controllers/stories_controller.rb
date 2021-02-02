class StoriesController < ApplicationController

  def show
    story = Story.find_by_id(params[:id])
    if story.present?
      render json: {story: story}, status: 200
    else
      render json: {erro: "There is not any story with given uniqe id."}, status: 400
    end
  end

  def create
    begin
      url = params["url"]
      raise "url not present" if url.blank?
      story = Story.find_by_url(params["url"])
      if story.blank?
        story = Story.create(url: url, scrape_status: "pending")
        ScrapeUrlJob.perform_later(story)
      end
      render json: {story_id: story.id}, status: 200
    rescue => e
      byebug
      render json: {error: e}, status: 400
    end
  end

  private
    def story_params
      params.require(:story).permit(:url, :canonical_url, :type, :title, :scrape_status)
    end
end
