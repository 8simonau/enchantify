class CreateStories < ActiveRecord::Migration[7.1]
  def change
    create_table :stories do |t|
      t.boolean :is_favorite
      t.integer :playcount
      t.string :title
      t.text :text
      t.references :child, null: false, foreign_key: true
      t.references :voice, null: false, foreign_key: true

      t.timestamps
    end
  end
end
