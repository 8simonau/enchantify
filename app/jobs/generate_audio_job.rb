class GenerateAudioJob < ApplicationJob
  queue_as :default

  def perform(story)
    # Do something later
    url = "https://api.elevenlabs.io/v1/text-to-speech/#{story.voice.token}"
    body = {
      text: story.text,
      model_id: "eleven_multilingual_v1",
      voice_settings: {
        stability: 1,
        similarity_boost: 0
      }
    }
    puts 'Sending text to TTS'
    response = Faraday.post(url) do |req|
      req.headers['accept'] = 'audio/mpeg'
      req.headers['Content-Type'] = 'application/json'
      req.headers['xi-api-key'] = ENV.fetch("ELEVENLABS_KEY")
      req.options.timeout = 300
      req.body = body.to_json
    end

    puts "audio file generated, attaching response"
    story.audio.attach(io: StringIO.new(response.body), filename: "audio.mp3", content_type: "audio")
    story.save!
  end
end
