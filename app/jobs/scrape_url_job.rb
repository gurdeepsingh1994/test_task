class ScrapeUrlJob < ApplicationJob
  queue_as :default
  require 'nokogiri'
  require 'open-uri'

  def perform(story)
    page = Nokogiri::HTML(open(url))
    canonical_url = page.search("link[rel='canonical']").map{|n| n['href']}
    # page = MetaInspector.new(url)
    # meta = page.meta
    # canonical_url = page.canonicals[0].try(:[], "href")
    # og_ur
    # story.title = meta['og:title']
    # story.url = meta['og:url']
    # story.og_type = meta['og:type']
    # story.canonical_url = page.canonicals[0].try(:[], "href")
    # story.images.build(url: meta['og:image'] , image_type: meta['og:image:type'], width:  meta['og:image:width'], height: meta['og:image:height'])
    # story.save!
  end
end
