class CreateOptions < ActiveRecord::Migration[7.1]
  def change
    create_table :options do |t|
      t.string :type
      t.string :name

      t.timestamps
    end
  end
end
