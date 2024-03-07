class VoicesController < ApplicationController
  def index
    @voices = Voice.all
    @title = "Voix"
  end

  def new
    @voice = Voice.new
    @title = "Voix"
  end

  def create
    @voice = Voice.new(voice_params)
    @voice.user = current_user
    if @voice.save
      AddVoiceToElevenlabsJob.perform_now(@voice)
      redirect_to voices_path, status: :see_other
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @voice = Voice.find(params[:id])
    if Story.where(voice: @voice).empty?
      @voice.destroy
      DeleteVoiceInElevenlabsJob.perform_now(@voice)
      flash[:notice] = "Successfully deleted"
    else
      flash[:alert] = "Impossible, used in stories"
    end
    redirect_to voices_path, status: :see_other
  end

  private

  def voice_params
    params.require(:voice).permit(:name, :audio)
  end
end
