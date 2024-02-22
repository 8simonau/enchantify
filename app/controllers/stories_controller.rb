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
      # test text waiting for implementation of ChatGPT job
      GenerateTextJob.perform_now(@story)
      GenerateAudioJob.perform_now(@story)
    end
  end

  def new
    @story = Story.new
    @story.playcount = 0
    # to be modified with active_child
    @story.child = Child.first
    # to be modified with selected voice
    @story.voice = current_user.voices.first
    @story.title = "This story is being created..."
    @story.text = "A magic adventure will appear here soon."
    @story.save!
    redirect_to story_select_options_path(@story)
  end

  def create
  end

end
