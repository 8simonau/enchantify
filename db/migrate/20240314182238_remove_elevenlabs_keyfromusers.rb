class RemoveElevenlabsKeyfromusers < ActiveRecord::Migration[7.1]
  def change
    remove_column :users, :elevenlabs_key
    remove_column :users, :cloudinary_url
    remove_column :users, :openai_key
  end
end
