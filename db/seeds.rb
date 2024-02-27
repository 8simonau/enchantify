puts "generate one user and 5 children"


john = User.create(first_name: "John", last_name: "Papa", email: "john@mail.com", password: "123456", admin: true)

emma = Child.new(first_name: "Emma", birth_date: "01/05/2018", story_duration: 120)
emma.avatar.attach(io: File.open("app/assets/images/emma_picture.jpg"), filename: "emma.png", content_type: "image/png")
emma.user = john
emma.save!

john.update(active_child: emma)

matheo = Child.new(first_name: "Matheo", birth_date: "01/05/2018", story_duration: 90)
matheo.avatar.attach(io: File.open("app/assets/images/matheo_picture.jpg"), filename: "matheo.png", content_type: "image/png")
matheo.user = john
matheo.save!

mike = Child.new(first_name: "Mike", birth_date: "03/03/2020", story_duration: 60)
mike.avatar.attach(io: File.open("app/assets/images/mike_picture.jpg"), filename: "mike.png", content_type: "image/png")
mike.user = john
mike.save!

joelle = Child.new(first_name: "Joelle", birth_date: "01/01/2017", story_duration: 100)
joelle.avatar.attach(io: File.open("app/assets/images/joelle_picture.jpg"), filename: "joelle.png", content_type: "image/png")
joelle.user = john
joelle.save!

yann = Child.new(first_name: "Yann", birth_date: "01/10/2020", story_duration: 50)
yann.avatar.attach(io: File.open("app/assets/images/yann_picture.jpg"), filename: "yann.png", content_type: "image/png")
yann.user = john
yann.save!

puts "generate 5 characters"

princesse = Option.new(category: "Personnage", name: "La Princesse")
princesse.picture.attach(io: File.open("app/assets/images/princesse_picture.webp"), filename: "princesse.png", content_type: "image/png")
princesse.description = "Peinture numérique d une élégante, gracieuse et très jeune princesse aux cheveux longs. Elle porte une robe rose et une couronne avec des proportions stylisées, des textures lisses, et un contraste élevé avec une seul fois le meme personnage dans l image."
princesse.save!

patate = Option.new(category: "Personnage", name: "La Patate")
patate.picture.attach(io: File.open("app/assets/images/patate_picture.png"), filename: "patate.png", content_type: "image/png")
patate.description = "Dessin d une pomme de terre amusante, pas très propre et un peu disgracieuse. Style bande dessinée, textures grossières, images pastel, faible contraste. Un seul personnage dans l image et en un seul exemplaire."
patate.save!

renard = Option.new(category: "Personnage", name: "Le Renard")
renard.picture.attach(io: File.open("app/assets/images/renard_picture.png"), filename: "renard.png", content_type: "image/png")
renard.description = "Dessin style manga de grande qualité et complètement colorié d un renard roux, mince, élégant et mystérieux, avec de grands yeux expressifs. On voit son corps entier de profil, en mouvement, légèrement flou. Couleurs et traits légers, un seul personnage sur l image en un seul exemplaire."
renard.save!

lutin = Option.new(category: "Personnage", name: "Le Lutin")
lutin.picture.attach(io: File.open("app/assets/images/lutin_picture.webp"), filename: "lutin.png", content_type: "image/png")
lutin.description = "Peinture numérique d un lutin coquin et malin. il porte une tenue verte et un panier remplie de gourmandises avec des proportions stylisées, des textures lisses, et un contraste élevé avec un seul personnage dans l image."
lutin.save!

ninja = Option.new(category: "Personnage", name: "Le Ninja")
ninja.picture.attach(io: File.open("app/assets/images/ninja_picture.webp"), filename: "ninja.png ", content_type: "image/png")
ninja.description = "Peinture numérique d un ninja souriant et discret. il porte une tenue noire avec une cagoule noire et un nunchaku en bois, accomplissant une acrobatie avec des proportions stylisées, des textures lisses, et un contraste élevé avec un seul personnage dans l image."
ninja.save!

puts "generate 4 places"

forest = Option.new(category: "Lieu", name: "Forêt")
forest.picture.attach(io: File.open("app/assets/images/forest_picture.png"), filename: "forest.png ", content_type: "image/png")
forest.description = "placeholder"
forest.save!

castle = Option.new(category: "Lieu", name: "Château")
castle.picture.attach(io: File.open("app/assets/images/castle_picture.png"), filename: "castle.png ", content_type: "image/png")
castle.description = "placeholder"
castle.save!

boat = Option.new(category: "Lieu", name: "Bateau")
boat.picture.attach(io: File.open("app/assets/images/boat_picture.png"), filename: "Boat.png ", content_type: "image/png")
boat.description = "placeholder"
boat.save!

underwater_city = Option.new(category: "Lieu", name: "Cité sous la mer")
underwater_city.picture.attach(io: File.open("app/assets/images/underwatercity_picture.png"), filename: "UnderwaterCity.png ", content_type: "image/png")
underwater_city.description = "placeholder"
underwater_city.save!

puts "generate 4 items"

hat = Option.new(category: "Objet", name: "Chapeau")
hat.picture.attach(io: File.open("app/assets/images/hat_picture.png"), filename: "hat.png", content_type: "image/png")
hat.description = "placeholder"
hat.save!

bubble_gun = Option.new(category: "Objet", name: "Pistomousse")
bubble_gun.picture.attach(io: File.open("app/assets/images/bubblegun_picture.png"), filename: "BubbleGun.png", content_type: "image/png")
bubble_gun.description = "placeholder"
bubble_gun.save!

dress = Option.new(category: "Objet", name: "Robe")
dress.picture.attach(io: File.open("app/assets/images/dress_picture.png"), filename: "Dress.png", content_type: "image/png")
dress.description = "placeholder"
dress.save!

sword = Option.new(category: "Objet", name: "Epée de feu")
sword.picture.attach(io: File.open("app/assets/images/sword_picture.png"), filename: "sword.png", content_type: "image/png")
sword.description = "placeholder"
sword.save!

puts "generate 1 voice"

# Emily's voice from Eleven Labs
voice = Voice.new(name: "Emily",
                  token: "x0420l7aKcZo6KFeBpln")
voice.user = john
voice.audio.attach(io: File.open("app/assets/audio/emily_sample.mp3"), filename: "emily_sample.mp3", content_type: "audio")
voice.save!

puts "generate 1 story"

story = Story.new(title: "Blanche-Neige",
                  text: "Une reine était assise à sa fenêtre encadrée de bois d'ébène et cousait. Tout en tirant l'aiguille, elle regardait voler les blancs flocons. Elle se piqua au doigt et trois gouttes de sang tombèrent sur la neige. Ce rouge sur ce blanc faisait si bel effet qu'elle se dit : « Si seulement j'avais un enfant aussi blanc que la neige, aussi rose que le sang, aussi noir que le bois de ma fenêtre ! » Peu de temps après, une fille lui naquit ; elle était blanche comme neige, rose comme sang et ses cheveux étaient noirs comme de l'ébène. On l'appela Blanche-Neige.",
                  options: [Option.last, Option.first, Option.find_by_name("Forêt")],
                  prompts: "['beginning', 'danger', 'victory']",
                  playcount: 0,
                  is_favorite: false)
story.voice = voice
story.child = emma

story.audio.attach(io: File.open("app/assets/audio/story_sample.mp3"), filename: "blancheneige.mp3", content_type: "audio")
story.save!
