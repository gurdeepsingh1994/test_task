class ScrapeUrlJob < ApplicationJob
  queue_as :default
  require 'nokogiri'
  require 'open-uri'

  def perform(story)
    page = Nokogiri::HTML(open(story.url))

    story.title = page.search("meta[property='og:title']").first['content'] rescue ""
    # story.url = page.search("meta[property='og:url']").first['content'] rescue ""
    story.og_type = page.search("meta[property='og:type']").first['content'] rescue ""
    story.canonical_url = page.search("link[rel='canonical']").first['href'] rescue ""
    story.scrape_status = "done"

    story.save

    page.search(
      "meta[property='og:image'], meta[property='og:image:width'], 
      meta[property='og:image:height'], meta[property='og:image:alt'], 
      meta[property='og:image:type']").each{ |obj|

        if (obj['property'] == "og:image")
          story.images.create( url: obj['content'] )

        elsif (obj['property'] == "og:image:width")
          story.images.last.update(width: obj['content'])

        elsif (obj['property'] == "og:image:height")
          story.images.last.update(height: obj['content'])

        elsif (obj['property'] == "og:image:alt")
          story.images.last.update(alt: obj['content'])

        elsif (obj['property'] == "og:image:type")
          story.images.last.update(image_type: obj['content'])

        end
    }
    
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
