class StoryOptionsController < ApplicationController
  def select_options
    @options = Option.all
    @story = Story.find(params[:story_id])
  end

  def create
    @story = Story.find(params[:story_id])
    @option = Option.find(params[:option])
    @story_option = StoryOption.new(option_id: params[:option], story_id: params[:story_id])
    @story_option.save!
  end
end
