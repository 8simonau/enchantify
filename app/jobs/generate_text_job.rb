class GenerateTextJob < ApplicationJob
  queue_as :default

  ADDITIONAL_PARAMETERS = [
    "C'est une histoire joyeuse",
    "C'est une histoire qui fait un peu peur",
    "C'est une histoire qui parle du pouvoir de l'amitié",
    "C'est une histoire qui parle des relations parents-enfants",
    "C'est une histoire qui parle d'apprentissage",
    "C'est une histoire qui parle de grandir",
    "C'est une histoire d'aventure",
    "C'est une histoire qui fait découvrir des pays lointains",
    "C'est une histoire qui fait rire",
    "C'est une histoire un peu triste",
    "C'est une histoire avec un personnage secondaire : un livre qui parle",
    "C'est une histoire avec un personnage secondaire : un chat volant",
    "C'est une histoire avec un personnage secondaire : un grand cheval",
    "C'est une histoire avec un personnage secondaire : deux assiettes qui roulent",
    "C'est une histoire avec des personnages secondaires : des jumeaux espiègles"
  ]

  def perform(story, token_count = 1500, prompt_count = 3)
    # variables
    puts "get story options"
    options = story.options_hash
    url = "https://api.openai.com/v1/chat/completions"
    additional_parameter = ADDITIONAL_PARAMETERS.sample
    puts additional_parameter

    preprompt = <<-STRING.squish
    Vous êtes un narrateur francophone expérimenté qui invente des histoires
    originales, positives et stimulantes pour les enfants de 3 à 8 ans. Vous
    devez utiliser des mots et des concepts simples pour que l'histoire soit
    bien comprise par les enfants. Vos histoires mettent en scène un personnage
    principal, un environnement et un objet qui vous seront donnés en paramètres.
    Les histoires doivent commencer par une brève description du personnage
    principal. Le personnage est confronté à un défi et le surmonte grâce à ses
    qualités et à son objet unique. #{additional_parameter}. La conclusion doit
    être courte. Votre réponse est un objet .json fonctionnel avec 3 clés : un
    titre (\"title\"), une liste de #{prompt_count} prompts (\"prompts\") qui
    décrivent en 5 mots chacun les principales séquences de l'histoire (ces
    chaînes seront utilisées pour prompter DALLE 3 et illustrer l'histoire) et
    le texte (\"text\") qui doit contenir au moins 3 paragraphes.
    STRING

    parameters = <<-STRING.squish
    Ecris une histoire :
    - le personnage principal est : #{options["Personnage"]}. Il ou elle est
    jeune et un enfant peut s'y identifier.
    - l'aventure prend place ici : #{options["Lieu"]}.
    - #{options["Personnage"]} a un objet : #{options["Objet"]} qui l'aide à
    accomplir ses objectifs.
    STRING

    # build request body
    body = {
      "model": "gpt-3.5-turbo-0125",
      "max_tokens": token_count,
      "response_format": { "type": "json_object" },
      "messages": [
        {
          "role": "system",
          "content": preprompt
        },
        {
          "role": "user",
          "content": parameters
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
    content = choice["message"]["content"]
    content << "}" unless content[-1] == "}"
    puts content
    content_hash = JSON.parse(content)
    puts content_hash
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
      body[:messages] << { "role": "assistant", "content": text }
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

    prompt_array = JSON.parse(story.prompts)
    prompt_array.each do |p|
      GenerateImageJob.perform_later(story, p)
    end
  end
end
