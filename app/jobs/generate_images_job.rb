class ImagesJob < ApplicationJob
  queue_as :default

  def perform(story)
    # Do something later

    curl_command = %(curl -X POST "https://api.openai.com/v1/images/generations" \
                    -H "Content-Type: application/json" \
                    -H "Authorization: Bearer #{ENV.fetch 'OPENAI_API_KEY'}" \
                    -d '{"model": "dall-e-3", "prompt": "#{Story.text}", "n": 3, "size": "1024x1024"}')

    response = `#{curl_command}`
    puts response
  end
end
