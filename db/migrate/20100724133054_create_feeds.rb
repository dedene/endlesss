class CreateFeeds < ActiveRecord::Migration
  def self.up
    create_table :feeds do |t|
      t.string :type
      t.string :name
      t.string :shortname      
      t.string :feed_type      
      t.integer :site_id
      t.string :url
      
      t.timestamps
    end
  end

  def self.down
    drop_table :feeds
  end
end
