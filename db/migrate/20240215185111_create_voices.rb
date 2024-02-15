class CreateVoices < ActiveRecord::Migration[7.1]
  def change
    create_table :voices do |t|
      t.string :name
      t.string :token
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
