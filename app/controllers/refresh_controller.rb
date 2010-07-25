class RefreshController < ApplicationController
  require 'rss/1.0'
  require 'rss/2.0'

  def index
    feeds = Feed.all
    feeds.each do |f| 
      source = f.url
      content = ""
      open(source) do |s| content = s.read end
      rss = RSS::Parser.parse(content, false)
      rss.items.each do |i|
        h = Hpricot(i.description)
        s = f.shots.find_or_create_by_url(i.link)
        s.update_attributes(
          :pubdate => i.pubDate.to_s,
          :img => h.search('//a/img')[0].attributes['src'],
          :width => h.search('//a/img')[0].attributes['width'],
          :height => h.search('//a/img')[0].attributes['height'],
          :title => i.title,
          :author => i.author)
      end
    end
  end
end
