class GenerateTextJob < ApplicationJob
  queue_as :default

  ADDITIONAL_PARAMETERS = {
    theme: [
      "joyeuse",
      "qui parle du pouvoir de l amitie",
      "qui parle des relations parents-enfants",
      "qui parle d apprentissage",
      "qui parle de grandir",
      "d aventure",
      "qui fait decouvrir des pays lointains",
      "qui fait rire",
    ],

    character: [
      "un livre qui parle",
      "un chat volant",
      "un cheval qui chuchote",
      "une petite magicienne",
      "un chapeau qui chante",
      "un ecureuil discret"
    ],

    quality: [
      "le courage",
      "l ouverture a l inconnu",
      "l humour",
      "la force de conviction",
      "la reflexion",
      "la patience"
    ]
  }

  def perform(story, token_count = 700, prompt_count = 4)
    # variables
    params = story.options_hash
    url = "https://api.openai.com/v1/chat/completions"
    theme = ADDITIONAL_PARAMETERS[:theme].sample
    secondary_character = ADDITIONAL_PARAMETERS[:character].sample
    quality = ADDITIONAL_PARAMETERS[:quality].sample

    preprompt = <<-STRING.squish
    Vous êtes un narrateur francophone experimente qui invente des histoires
    originales, positives et stimulantes pour les enfants de 3 a 8 ans. Vous
    devez utiliser des mots et des concepts simples pour que l histoire soit
    bien comprise par les enfants. Vos histoires mettent en scene un personnage
    principal, un environnement et un objet qui vous seront donnes en parametres.
    Votre reponse est un objet .json fonctionnel avec 3 cles :
    1. un titre (title),
    2. une liste de #{prompt_count} prompts (prompts) qui decrivent chacun en
    un court paragraphe une des scenes principales de l histoire. Ces paragraphes
    seront utilisees pour prompter DALLE 3 et illustrer l histoire, il faut donc
    qu'ils comprennent des descriptions visuelles précises,
    3. le texte de l histoire (text).
    L histoire doit commencer par une breve description du personnage
    principal. Le personnage est confronte a un defi et le surmonte.
    STRING

    parameters = <<-STRING.squish
    Ecrivez une histoire :
    C est une histoire #{theme}.
    Elle comprend un personnage secondaire : #{secondary_character}.
    Elle montre l importance de cette qualite : #{quality}.
    Le personnage principal est : #{params["Personnage"][0]}, #{params["Personnage"][1]} Il ou elle est
    jeune et un enfant peut s y identifier. Donnez lui un prenom francophone simple.
    L aventure prend place ici : #{params["Lieu"][0]}, #{params["Lieu"][1]}
    #{params["Personnage"][0]} a un objet : #{params["Objet"][0]}, #{params["Objet"][1]}. Cet objet l aide a
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
      puts req.body
    end

    # puts response
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
