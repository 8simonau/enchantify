class ChangeVoiceNullConstraintInStories < ActiveRecord::Migration[7.1]
  def change
    change_column_null :stories, :voice_id, true
  end
end
