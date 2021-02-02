class CreateImages < ActiveRecord::Migration[6.0]
  def change
    create_table :images do |t|
      t.string :url
      t.string :image_type
      t.string :width
      t.string :height
      t.string :alt
      t.belongs_to :story, null: false, foreign_key: true

      t.timestamps
    end
  end
end
