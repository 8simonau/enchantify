class CreateChildren < ActiveRecord::Migration[7.1]
  def change
    create_table :children do |t|
      t.string :first_name
      t.date :birth_date
      t.integer :story_duration
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
