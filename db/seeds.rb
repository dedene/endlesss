# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
s = Site.create(
      :name => 'Dribbble',
      :shortname => 'dribbble',
      :url => 'http://dribbble.com')
            
s.feeds.build(
      :url => 'http://dribbble.com/shots/everyone.rss',
      :name => 'Everyone',
      :shortname => 'everyone',
      :type => 'main',
      :feed_type => 'rss').save
s.feeds.build(
      :url => 'http://dribbble.com/shots/debuts.rss',
      :name => 'Debuts',
      :shortname => 'debuts',      
      :type => 'main',
      :feed_type => 'rss').save 