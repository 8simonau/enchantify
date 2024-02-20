class GenerateTextJob < ApplicationJob
  queue_as :default

  def perform(story)
    # Do something later
    url = "https://api.openai.com/v1/chat/completions"
    body = {
      "model": "gpt-3.5-turbo-0125",
      "max_tokens": 1000,
      "messages": [
        {
          "role": "system",
          "content": "You are a skilled storyteller, adept at inventing original, positive, deep and thought-provoking stories for children aged 3 to 8 years old.  You write in French. You should use simple words and concepts, to ensure the story can be fully understood by young children. Your stories should be ~1000 words long and feature a number of characters, places, items, adventures, etc. that will be given to you as parameters. Stories should start with a short description of the main character. The main character should then face a challenge and overcome it thanks to their friends, their braveness and their unique item. The conclusion should be short."
        },
        {
          "role": "user",
          "content": "Generate a story: - its main character is a young child named Mara. - it takes place in an magnificent castle and the surrouding fields. - Mara has an army of mischievous goblins who help her pull pranks on castle inhabitants."
        }
      ]
    }

    response = Faraday.post(url) do |req|
      req.headers =
    end
  end
end
