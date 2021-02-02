class CreateStories < ActiveRecord::Migration[6.0]
  def change
    create_table :stories do |t|
      t.string :url
      t.string :canonical_url
      t.string :og_type
      t.string :title
      t.integer :scrape_status

      t.timestamps
    end
    add_index :stories, :url
    add_index :stories, :canonical_url
  end
end
