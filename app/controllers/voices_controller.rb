class VoicesController < ApplicationController
  def index
    @voices = Voice.all
  end

  def new
    @voice = Voice.new
  end

  def create
    @voice = Voice.new(voice_params)
    @voice.user = current_user
    if @voice.save!
      AddVoiceToElevenlabsJob.perform_now(@voice)
      redirect_to voices_path, status: :see_other
    else
      puts @voice.errors.messages
      render :new, status: :unprocessable_entity
    end
  end

  private

  def voice_params
    params.require(:voice).permit(:name, :audio)
  end

end
