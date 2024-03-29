class AddVoiceToElevenlabsJob < ApplicationJob
  queue_as :default

  def perform(voice)
    uri = URI('https://api.elevenlabs.io/v1/voices/add')
    req = Net::HTTP::Post.new(uri)
    req['xi-api-key'] = ENV.fetch("ELEVENLABS_KEY")

    req.set_form(
      [
        [
          'files',
          URI.parse(voice.audio.url).open
        ],
        [
          'name',
          voice.name
        ],
        [
          'description',
          'Voice sample for ElevenLabs'
        ]
      ],
      'multipart/form-data'
    )

    req_options = {
      use_ssl: uri.scheme == 'https'
    }
    res = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(req)
    end

    voice.update(token: JSON.parse(res.body)["voice_id"])
  end
end
