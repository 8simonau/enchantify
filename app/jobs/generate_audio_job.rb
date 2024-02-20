class GenerateAudioJob < ApplicationJob
  queue_as :default

  def perform(story)
    # Do something later
    url = "https://api.elevenlabs.io/v1/text-to-speech/#{story.voice_id}"
    body = {
      text: story.text
    }

    response = Faraday.post(url) do |req|
      req.headers['accept'] = 'audio/mpeg'
      req.headers['Content-Type'] = 'application/json'
      req.headers['xi-api-key'] = ENV.fetch("ELEVENLABS_KEY")
      req.body = body.to_json
    end

    story.audio.attach(io: StringIO.new(response.body), filename: "audio.mp3", content_type: "audio")
    story.save!
  end
end
