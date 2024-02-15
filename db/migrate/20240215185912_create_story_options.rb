class CreateStoryOptions < ActiveRecord::Migration[7.1]
  def change
    create_table :story_options do |t|
      t.references :option, null: false, foreign_key: true
      t.references :story, null: false, foreign_key: true

      t.timestamps
    end
  end
end
