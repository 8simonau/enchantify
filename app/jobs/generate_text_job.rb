class GenerateTextJob < ApplicationJob
  queue_as :default

  ADDITIONAL_PARAMETERS = {
    theme: [
      "joyeuse",
      "qui fait un peu peur",
      "qui parle du pouvoir de l'amitié",
      "qui parle des relations parents-enfants",
      "qui parle d'apprentissage",
      "qui parle de grandir",
      "d'aventure",
      "qui fait découvrir des pays lointains",
      "qui fait rire",
      "un peu triste"
    ],

    character: [
      "un livre qui parle",
      "un chat volant",
      "un cheval qui chuchote",
      "un croissant croustillant",
      "une petite magicienne",
      "un chapeau qui chante"
    ],

    quality: [
      "courage",
      "ouverture à l'inconnu",
      "humour",
      "force de conviction",
      "réflexion"
    ]
  }

  def perform(story, token_count = 800, prompt_count = 3)
    # variables
    options = story.options_hash
    url = "https://api.openai.com/v1/chat/completions"
    theme = ADDITIONAL_PARAMETERS[:theme].sample
    secondary_character = ADDITIONAL_PARAMETERS[:character].sample
    quality = ADDITIONAL_PARAMETERS[:quality].sample

    preprompt = <<-STRING.squish
    Vous êtes un narrateur francophone expérimenté qui invente des histoires
    originales, positives et stimulantes pour les enfants de 3 à 8 ans. Vous
    devez utiliser des mots et des concepts simples pour que l'histoire soit
    bien comprise par les enfants. Vos histoires mettent en scène un personnage
    principal, un environnement et un objet qui vous seront donnés en paramètres.
    Votre réponse est un objet .json fonctionnel avec 3 clés :
    un titre (\"title\"),
    une liste de #{prompt_count} prompts (\"prompts\") qui décrivent un paragraphe précis et détaillé les principales séquences de l'histoire (ces paragraphes seront utilisées pour prompter DALLE 3 et illustrer l'histoire),
    et le texte de l'histoire (\"text\").
    L'histoire doit commencer par une brève description du personnage
    principal. Le personnage est confronté à un défi et le surmonte.
    STRING

    parameters = <<-STRING.squish
    Ecris une histoire :
    C'est une histoire #{theme}.
    Elle comprend un ou des personnages secondaires : #{secondary_character}.
    Elle montre l'importance de cette qualité : #{quality}.
    Le personnage principal est : #{options["Personnage"]}. Il ou elle est
    jeune et un enfant peut s'y identifier. Donnez-lui un prénom francophone simple.
    L'aventure prend place ici : #{options["Lieu"]}.
    #{options["Personnage"]} a un objet : #{options["Objet"]}, qui l'aide à
    accomplir ses objectifs.
    STRING

    puts preprompt
    puts parameters

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

    puts response.body

    # parse response
    puts "parse response"
    choice = JSON.parse(response.body)["choices"][0]
    content = choice["message"]["content"]
    content << "}" unless content[-1] == "}"
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

    #generate pictures
    prompt_array = JSON.parse(story.prompts)
    prompt_array.each do |p|
      GenerateImageJob.perform_later(story, p)
    end
  end
end
