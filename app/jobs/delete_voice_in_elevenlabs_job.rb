class DeleteVoiceInElevenlabsJob < ApplicationJob
  queue_as :default

  def perform(voice)
    url = "https://api.elevenlabs.io/v1/voices/#{voice.token}"
    Faraday.delete(url) do |req|
      req.headers['xi-api-key'] = ENV.fetch("ELEVENLABS_KEY")
    end
  end
end
