class CreateInputUrls < ActiveRecord::Migration[6.0]
  def change
    create_table :input_urls do |t|
      t.string :url
      t.belongs_to :story, null: false, foreign_key: true

      t.timestamps
    end
    add_index :input_urls, :url
  end
end
