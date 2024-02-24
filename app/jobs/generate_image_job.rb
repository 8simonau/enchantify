class GenerateImageJob < ApplicationJob
  queue_as :default

  def perform(story, prompt)
    # Do something later
    preprompt = <<-STRING.squish
    Vous êtes un talentueux illustrateur de contes pour enfants qui dessine au
    pinceau des illustrations. Celles-ci doivent être colorées et belles, et
    stimuler l'imagination des enfants. Chaque illustration est créée à l'aide
    d'un personnage principal (un enfant), un lieu et un objet magique. Vos
    images ne contiennent jamais de texte.
    Voici les paramètres:
    STRING

    story.options_hash.each do |k, v|
      preprompt << "#{k} : #{v}. "
    end
    full_prompt = preprompt + " Voici l'action à décrire : " + prompt

    url = "https://api.openai.com/v1/images/generations"
    body = {
      "model": "dall-e-3",
      "prompt": full_prompt,
      "size": "1024x1024"
    }

    response = Faraday.post(url) do |req|
      req.headers['Content-Type'] = 'application/json'
      req.headers['Authorization'] = 'Bearer ' + ENV.fetch("OPENAI_KEY")
      req.options.timeout = 300
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

    file = URI.open(JSON.parse(response.body)["data"][0]["url"])
    story.pictures.attach(io: file, filename: "#{prompt}.png", content_type: "image/png")
    story.save!
    puts "attached picture based on #{prompt}"
  end
end
