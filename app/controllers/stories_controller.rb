class StoriesController < ApplicationController
  def index
    @stories = Story.where(child: current_user.active_child).order('is_favorite desc, created_at desc')
    @title = "Mes histoires"
    @background = "planet"
  end

  def show
    @background = "loading"
    @story = Story.find(params[:id])
    @story.update(playcount: @story.playcount + 1)
    @recent_stories = Story.all.order(created_at: :desc)[1..2]
    @title = "Mon histoire"
  end

  def new
    @story = Story.new
    @story.playcount = 0
    @story.is_favorite = false
    @story.child = current_user.active_child
    @story.title = "En cours d'invention..."
    @story.text = "Une aventure magique va bientôt apparaître."
    @story.save!
    redirect_to new_story_story_option_path(@story)
  end

  def create
  end

  def edit
    @story = Story.find(params[:id])
    @voices = Voice.all
    @title = "Nouvelle histoire"
    @background = "builders"
  end

  def update
    @story = Story.find(params[:id])
    if @story.update(voice_id: params[:story][:voice_id])
      redirect_to story_path(@story)
      # if no audio, then we call ElevenLabs
      unless @story.audio.attached?
        sleep 1 while @story.reload.text == "Une aventure magique va bientôt apparaître."
        GenerateAudioJob.perform_later(@story)
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def render_story
    @story = Story.find(params[:id])
    if @story.audio.attached?
      render partial: "story_display"
    else
      head :no_content
    end
  end

  def mark_favorite
    @story = Story.find(params[:id])
    @story.update(is_favorite: true)
  end

  def toggle_favorite
    @story = Story.find(params[:id])
    @story.update(is_favorite: !@story.is_favorite)
  end

  def destroy
    @story = Story.find(params[:id])
    @story.destroy
    flash[:notice] = "Histoire supprimée"
    redirect_to stories_path, status: :see_other
  end
end
