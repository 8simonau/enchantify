class StoriesController < ApplicationController
  def index
    @stories = Story.all
  end

  def show
    @story = Story.find(params[:id])
    @story.update(playcount: @story.playcount + 1)
    # if no text, call ChatGPT
    # if no audio, then we call ElevenLabs
    unless @story.audio.valid?
      GenerateTextJob.perform_now(@story)
      GenerateAudioJob.perform_now(@story)
    end
  end

  def new
    @story = Story.new
    @story.playcount = 0
    @story.child = Child.find(session[:active_child]["id"])
    @story.voice = Voice.last
    @story.title = "This story is being created..."
    @story.text = "A magic adventure will appear here soon."
    @story.save!
    redirect_to new_story_story_option_path(@story)
  end

  def create
  end

  def edit
    @story = Story.find(params[:id])
  end

  def update
    @story = Story.find(params[:id])
    if @story.update(voice_id: params[:story][:voice_id])
      redirect_to story_path(@story)
    else
      render :new, status: :unprocessable_entity
    end
  end
end
