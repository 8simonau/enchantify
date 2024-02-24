class StoryOptionsController < ApplicationController
  def new
    @story = Story.find(params[:story_id])
    @story_option = StoryOption.new
    if @story.options.empty?
      @options = Option.where(category: "Character")
    elsif @story.options.size == 1
      @options = Option.where(category: "Place")
    elsif @story.options.size == 2
      @options = Option.where(category: "Item")
    end
  end

  def create
    @story = Story.find(params[:story_id])
    @story_option = StoryOption.new(option_id: params[:story_option][:option], story_id: params[:story_id])
    if @story_option.save!
      if @story.options.size == 3
        redirect_to edit_story_path(@story)
      else
        redirect_to new_story_story_option_path(@story)
      end
    else
      render :new, status: :unprocessable_entity
    end
  end
end
