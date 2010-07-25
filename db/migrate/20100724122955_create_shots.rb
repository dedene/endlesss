class CreateShots < ActiveRecord::Migration
  def self.up
    create_table :shots do |t|
      t.integer :feed_id
      
      t.string :url
      t.string :img
      t.integer :width
      t.integer :height
      t.string :title
      t.datetime :pubdate
      t.string :author
      t.string :location
      t.text :description

      t.timestamps
    end
    
    add_index :shots, :feed_id, :name => 'feed_id_ix'
    add_index :shots, :url, :name => 'url_ix'      
    
  end

  def self.down
    drop_table :shots
  end
end
