class AddPromptsToStories < ActiveRecord::Migration[7.1]
  def change
    add_column :stories, :prompts, :string
  end
end
