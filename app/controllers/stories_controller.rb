class StoriesController < ApplicationController

  def show
  end

  def create
  end

  private
    def story_params
      params.require(:story).permit(:url, :canonical_url, :type, :title, :scrape_status)
    end
end
