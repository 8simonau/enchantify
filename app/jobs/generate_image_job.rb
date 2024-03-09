class GenerateImageJob < ApplicationJob
  queue_as :default

  def perform(story, prompt)
    # Do something later
    preprompt = <<-STRING.squish
    Vous êtes un talentueux illustrateur de contes pour enfants qui dessine au
    pastel des illustrations de grande qualité. Celles-ci doivent être colorées et belles, et
    stimuler l'imagination des enfants. Les images sont en format portrait.
    STRING

    picture_description = " Voici à quoi ressemble le personnage principal : " + story.character_description

    story.options_hash.each do |k, v|
      picture_description << " L'illustration contient un #{k} : #{v}."
    end

    full_prompt = preprompt + picture_description + " Voici l'action à illustrer : " + prompt

    puts full_prompt

    url = "https://api.openai.com/v1/images/generations"
    body = {
      "model": "dall-e-3",
      "prompt": full_prompt,
      "size": "1024x1792"
    }

    response = Faraday.post(url) do |req|
      req.headers['Content-Type'] = 'application/json'
      req.headers['Authorization'] = 'Bearer ' + ENV.fetch("OPENAI_KEY")
      req.options.timeout = 300
      req.body = body.to_json
    end

    puts response.body

    file = URI.open(JSON.parse(response.body)["data"][0]["url"])
    x = story.pictures.attach(io: file, filename: "#{prompt}.png", content_type: "image/png")
    story.save!
    puts "attached picture based on #{prompt}"
  end
end
