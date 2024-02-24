class AddActiveChildToUsers < ActiveRecord::Migration[7.1]
  def change
    add_reference :users, :active_child, null: true, foreign_key: { to_table: :children }
  end
end
