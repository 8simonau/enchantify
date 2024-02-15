class ChangeColumnNameFromOption < ActiveRecord::Migration[7.1]
  def change
    rename_column :options, :type, :category
  end
end
