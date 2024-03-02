class AddColumnsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :elevenlabs_key, :string
    add_column :users, :cloudinary_url, :string
    add_column :users, :openai_key, :string
  end
end
