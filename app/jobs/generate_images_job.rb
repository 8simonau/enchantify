class GenerateImagesJob < ApplicationJob
  queue_as :default

    def perform(story)
      # Do something later
      url = "https://api.openai.com/v1/images/generations"
      body = {
        "model": "dall-e-3",
        "prompt": "#{story.text}",
        "size": "1024x1024"
      }

      response = Faraday.post(url) do |req|
        req.headers['Content-Type'] = 'application/json'
        req.headers['Authorization'] = 'Bearer ' + ENV.fetch("OPENAI_KEY")
        req.body = body.to_json
      end

      puts ""
      puts "*******************************"
      puts ""
      puts "IMAGE GEN RESPONSE:"
      puts ""
      puts response.body
      puts ""
      puts "*******************************"
      puts ""

      # story.audio.attach(io: StringIO.new(response.body), filename: "audio.mp3", content_type: "audio")
      # story.save!
      response
  end
end
