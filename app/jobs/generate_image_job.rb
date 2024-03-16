class GenerateImageJob < ApplicationJob
  queue_as :default

  def perform(story, prompt)
    # Do something later
    params = story.options_hash
    preprompt = <<-STRING.squish
    USE ONLY THE FOLLOWING SENTENCES AS A PROMPT AND DO NOT REWRITE IT. CREATE A
    VERTICAL IMAGE.
    Imagine :
    STRING
    # Voici l'histoire qui sert de theme : #{story.text}

    char_desc = " Le personnage principal est #{params["Personnage"][0]}, #{params["Personnage"][1]}"
    item_desc = " Le personnage principal tient ou porte #{params["Objet"][0]}, #{params["Objet"][1]}"
    place_desc = " L'action se passe ici : #{params["Lieu"][0]}, #{params["Lieu"][1]}."

    postprompt = <<-STRING.squish
    Pour cette image, utilizez un style de gravure sur bois typique
    des illustrations de livres pour enfants, où chaque element est rendu par des
    lignes franches et claires et des formes simplifiees. L utilisation de contrastes
    entre les textures sombres, semblables a de l encre, de la gravure sur bois et
    les zones plus claires apportera de la profondeur et de la dimension a la scene,
    L'effet global devrait etre d une beaute captivante et coloree, invitant les
    spectateurs a penetrer dans un monde unique."
    STRING

    full_prompt = preprompt + prompt + char_desc + item_desc + place_desc + postprompt

    puts full_prompt

    url = "https://api.openai.com/v1/images/generations"
    body = {
      "model": "dall-e-3",
      "prompt": full_prompt,
      # "quality": "hd",
      "size": "1024x1792",
    }

    response = Faraday.post(url) do |req|
      req.headers['Content-Type'] = 'application/json'
      req.headers['Authorization'] = 'Bearer ' + ENV.fetch("OPENAI_KEY")
      req.options.timeout = 300
      req.body = body.to_json
    end

    puts response.body

    file = URI.open(JSON.parse(response.body)["data"][0]["url"])
    x = story.pictures.attach(io: file, filename: "image.png", content_type: "image/png")
    story.save!
    puts "attached picture based on #{prompt}"
  end
end
