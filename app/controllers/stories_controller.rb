class StoriesController < ApplicationController
  def index
    @stories = Story.all
  end

  def show
    @story = Story.find(params[:id])
    @story.update(playcount: @story.playcount + 1)

    # respond_to do |format|
    #   format.html
    #   format.json { render json: @story.to_json }
    # end
  end

  def new
    @story = Story.new
    @story.playcount = 0
    @story.child = current_user.active_child
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
    @voices = Voice.all
  end

  def update
    @story = Story.find(params[:id])
    if @story.update(voice_id: params[:story][:voice_id])
      redirect_to story_path(@story)
      # if no audio, then we call ElevenLabs
      unless @story.audio.valid?
        sleep 1 while @story.text == "A magic adventure will appear here soon."
        GenerateAudioJob.perform_later(@story)
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def render_audio
    @story = Story.find(params[:id])
    if @story.audio.attached?
      render partial: "audio"
    else
      head :no_content
    end
  end
end
