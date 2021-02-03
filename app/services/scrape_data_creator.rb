class ScrapeDataCreator
  require 'nokogiri'
  require 'open-uri'

  def self.get_canonical_url(url)
    page = Nokogiri::HTML(open(url))
    canonical_url = page.search("link[rel='canonical']").first.try(:[], "href")
    og_url = page.search("meta[property='og:url']").first.try(:[], "content")
    canonical_url || og_url || url
  end

  def self.get_data(url)
    data = {}
    page = Nokogiri::HTML(open(url))
    data[:title] = page.search("meta[property='og:title']").first.try(:[], "content")
    data[:type] = page.search("meta[property='og:type']").first.try(:[], "content")

    data[:images_data] = page.search(
    "meta[property='og:image'], meta[property='og:image:width'],
    meta[property='og:image:height'], meta[property='og:image:alt'],
    meta[property='og:image:type']")

    data
  end
end