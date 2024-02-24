class AddDescriptionToOptions < ActiveRecord::Migration[7.1]
  def change
    add_column :options, :description, :string
  end
end
