class GenerateTextJob < ApplicationJob
  queue_as :default

  def perform(story)
    options = story.options_hash

    url = "https://api.openai.com/v1/chat/completions"
    body = {
      "model": "gpt-3.5-turbo-0125",
      "max_tokens": 500,
      "messages": [
        {
          "role": "system",
          "content": "You are a skilled storyteller, adept at inventing original,
          positive, deep and thought-provoking stories for children aged 3 to 8 years old.
          You write in French. You should use simple words and concepts, to ensure the story
          can be fully understood by young children. Your stories feature a number of
          characters, places, items, adventures, etc. that will be given to you as parameters.
          Stories should start with a short description of the main character.
          The main character should then face a challenge and overcome it thanks to their
          friends, their braveness and their unique item. The conclusion should be short.
          Your response should always be formatted as a json hash containing 6 keys keys: a title, a text, and exactly 4 short prompts
          to generate DALLE 3 pictures that illustrate the story. Each prompt should be named: \"prompt_{index}\" and contain the text of preceding prompts."
        },
        {
          "role": "user",
          "content": "Generate a story:
          - its main character is a young child named #{options["Character"]}.
          - it takes place here: #{options["Place"]}.
          - #{options["Character"]} has a #{options["Item"]} that helps them tackle challenges."
        }
      ]
    }

    response = Faraday.post(url) do |req|
      req.headers['Authorization'] = 'Bearer ' + ENV.fetch("OPENAI_KEY")
      req.headers['Content-Type'] = 'application/json'
      req.body = body.to_json
    end

    content = JSON.parse(response.body)["choices"][0]["message"]["content"]
    story.title = JSON.parse(content)["title"]
    story.text = JSON.parse(content)["text"]
    story.save!
    content
  end
end
