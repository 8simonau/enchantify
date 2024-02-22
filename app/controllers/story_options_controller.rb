class StoryOptionsController < ApplicationController
  def select_options
    @options = Option.all
    @story = Story.find(params[:story_id])
  end

  def create
    @story = Story.find(params[:story_id])
    @option = Option.find(params[:option])
    # if StoryOption already exits, then destroys
    if @story.options.include?(@option)
      StoryOption.find_by(story_id: params[:story_id], option: params[:option]).destroy
    else
      @story_option = StoryOption.new(option_id: params[:option], story_id: params[:story_id])
      @story_option.save!
    end
  end
end
