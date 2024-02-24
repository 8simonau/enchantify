class GenerateTextJob < ApplicationJob
  queue_as :default

  def perform(story, length = 1000)
    # variables
    puts "get story options"
    options = story.options_hash
    url = "https://api.openai.com/v1/chat/completions"

    # build request body
    body = {
      "model": "gpt-3.5-turbo-0125",
      "max_tokens": length,
      "response_format": { "type": "json_object" },
      "messages": [
        {
          "role": "system",
          "content": "Vous êtes un narrateur francophone expérimenté qui invente des histoires originales, positives et stimulantes pour les enfants de 3 à 8 ans. Vous devez utiliser des mots et des concepts simples pour que l'histoire soit bien comprise par les enfants. Vos histoires mettent en scène un personnage principal, un environnement et un objet qui vous seront donnés en paramètres. Les histoires doivent commencer par une brève description du personnage principal. Le personnage est confronté à un défi et le surmonte grâce à son courage et à son objet unique. La conclusion doit être courte. Votre réponse est un objet .json fonctionnel avec 3 clés : un titre (\"title\"), un array de 4 chaînes de caractères (\"prompts\") qui décrivent en 5 mots les principales séquences de l'histoire (ces chaînes seront utilisées pour prompter DALLE 3 et illustrer l'histoire) et le texte (\"text\") qui doit contenir au moins 5 paragraphes et 1000 mots."
        },
        {
          "role": "user",
          "content": "Ecris une histoire :
          - le personnage principal est un jeune enfant : #{options["Character"]}.
          - l'aventure prend place ici : #{options["Place"]}.
          - #{options["Character"]} a un objet : #{options["Item"]} qui l'aide à accomplir ses objectifs."
        }
      ]
    }

    # get OAI response
    puts "send request"
    response = Faraday.post(url) do |req|
      req.headers['Authorization'] = 'Bearer ' + ENV.fetch("OPENAI_KEY")
      req.headers['Content-Type'] = 'application/json'
      req.body = body.to_json
    end

    # parse response
    puts "parse response"
    choice = JSON.parse(response.body)["choices"][0]
    puts choice
    content = choice["message"]["content"]
    unless content[-1] == "}"
      content += "}"
    end
    content_hash = JSON.parse(content)
    puts "content ok"
    title = content_hash["title"]
    text = content_hash["text"]
    prompts = (content_hash["prompts"]).to_s
    puts "fields ok"

    # save title and prompts
    story.title = title
    story.prompts = prompts

    # if story is finished, save
    if choice["finish_reason"] != "length"
      story.text = text
      puts "saving"
      story.save!

    # else, send another request with previous text as input
    else
      puts "finishing story..."
      body["messages"] << { "role": "assistant", "content": text }
      puts body
      response = Faraday.post(url) do |req|
        req.headers['Authorization'] = 'Bearer ' + ENV.fetch("OPENAI_KEY")
        req.headers['Content-Type'] = 'application/json'
        req.body = body.to_json
      end

      # parse, add addl text and save
      content = JSON.parse(response.body)["choices"][0]["message"]["content"]
      unless content[-1] == "}"
        content += "}"
      end
      end_text = JSON.parse(content)["text"]
      text += end_text
      story.text = text
      story.save!
    end
  end
end
