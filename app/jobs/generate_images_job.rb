class GenerateImagesJob < ApplicationJob
  queue_as :default

  def perform(story, prompt)
    # Do something later
    preprompt = "Vous êtes un talentueux illustrateur de contes pour enfants qui dessine au pinceau des illustrations. Celles-ci doivent être colorées et belles, et stimuler l'imagination des enfants. Chaque illustration est créée à l'aide d'un personnage principal (un enfant), un lieu et un objet magique. Une phrase décrit l'action précise. Voici les paramètres: "
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
    return response

    url = URI.open()
    story.pictures.attach(io: StringIO.new(response.body), filename: "#{prompt}.jpg", content_type: "image/jpeg")
    story.save!
  end
end
