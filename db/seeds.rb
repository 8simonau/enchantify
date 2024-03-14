puts "generate one user and 2 children"


john = User.create(first_name: "John", last_name: "Papa", email: "john@mail.com", password: ENV.fetch("JOHN_MDP"), admin: true)

emma = Child.new(first_name: "Emma", birth_date: "01/05/2018", story_duration: 120)
emma.avatar.attach(io: File.open("app/assets/images/emma_picture.jpg"), filename: "emma.jpg", content_type: "image/jpg")
emma.user = john
emma.save!

john.update(active_child: emma)

matheo = Child.new(first_name: "Matheo", birth_date: "01/05/2018", story_duration: 90)
matheo.avatar.attach(io: File.open("app/assets/images/matheo_picture.jpg"), filename: "matheo.jpg", content_type: "image/jpg")
matheo.user = john
matheo.save!

puts "generate 6 characters"

princesse = Option.new(category: "Personnage", name: "La Princesse")
princesse.picture.attach(io: File.open("app/assets/images/princess_picture.jpg"), filename: "princesse.jpg", content_type: "image/jpg")
princesse.description = "Dessin au pastel d une élégante et jeune princesse aux cheveux mi longs. Elle porte une robe violette et un diadème étincelant."
princesse.save!

patate = Option.new(category: "Personnage", name: "La Patate")
patate.picture.attach(io: File.open("app/assets/images/potato_picture.jpg"), filename: "patate.jpg", content_type: "image/jpg")
patate.description = "Dessin au pastel dans un style de conte pour enfant, en couleur d une pomme de terre animée et boute en train, un peu ébouriffée."
patate.save!

renard = Option.new(category: "Personnage", name: "Le Renard")
renard.picture.attach(io: File.open("app/assets/images/fox_picture.jpg"), filename: "renard.jpg", content_type: "image/jpg")
renard.description = "Dessin au pastel de grande qualité, dans un style de conte pour enfant, d un grand renard roux, élégant et mystérieux, avec de petits yeux expressifs."
renard.save!

lutin = Option.new(category: "Personnage", name: "Le Lutin")
lutin.picture.attach(io: File.open("app/assets/images/elf_picture.jpg"), filename: "lutin.jpg", content_type: "image/jpg")
lutin.description = "Dessin au pastel de grande qualité, dans un style de conte pour enfant, d un lutin malicieux équipé d une belle tenue verte et d un chapeau."
lutin.save!

ninja = Option.new(category: "Personnage", name: "Le Ninja")
ninja.picture.attach(io: File.open("app/assets/images/ninja_picture.jpg"), filename: "ninja.jpg ", content_type: "image/jpg")
ninja.description = "Dessin au pastel dans un style de conte pour enfant de grande qualité d un ninja silencieux équipé d une tenue bleu nuit."
ninja.save!

ecoliere = Option.new(category: "Personnage", name: "L'Ecolière")
ecoliere.picture.attach(io: File.open("app/assets/images/schoolgirl_picture.jpg"), filename: "ecoliere.jpg ", content_type: "image/jpg")
ecoliere.description = "Dessin au pastel dans un style de conte pour enfant de grande qualité d une écolière sérieuse et enthousiaste qui se déplace à vélo. Elle porte un uniforme et un cartable."
ecoliere.save!

puts "generate 6 places"

forest = Option.new(category: "Lieu", name: "La Forêt")
forest.picture.attach(io: File.open("app/assets/images/forest_picture.jpg"), filename: "forest.jpg ", content_type: "image/jpg")
forest.description = "Dessin au pastel dans un style de conte pour enfant de grande qualité d une foret luxuriante et magique, fourmillant de plantes et d animaux dissimulés sous les feuilles et dans les branches."
forest.save!

underwater_city = Option.new(category: "Lieu", name: "La Mer")
underwater_city.picture.attach(io: File.open("app/assets/images/underwatercity_picture.jpg"), filename: "UnderwaterCity.jpg ", content_type: "image/jpg")
underwater_city.description = "Dessin au pastel dans un style de conte pour enfant de grande qualité d une petite cité sous marine posée sur le sable, aux maisons et aux palais faits de coquillages, dont les habitants sont de petits poissons colorés."
underwater_city.save!

castle = Option.new(category: "Lieu", name: "Le Château")
castle.picture.attach(io: File.open("app/assets/images/castle_picture.jpg"), filename: "castle.jpg ", content_type: "image/jpg")
castle.description = "Dessin au pastel dans un style de conte pour enfant de grande qualité d un chateau fantastique, monumental et mysterieux, avec de nombreuses tours à créneaux, en pierre blanche et entouré par des champs à perte de vue."
castle.save!

mountain = Option.new(category: "Lieu", name: "La Montagne")
mountain.picture.attach(io: File.open("app/assets/images/mountain_picture.jpg"), filename: "mountain.jpg ", content_type: "image/jpg")
mountain.description = "Dessin au pastel dans un style de conte pour enfant de grande qualité d une chaine de montagnes enneigées sous un ciel gris, avec des chemins, des grottes et de petits villages disséminés."
mountain.save!

boat = Option.new(category: "Lieu", name: "Le Bateau")
boat.picture.attach(io: File.open("app/assets/images/boat_picture.jpg"), filename: "boat.jpg ", content_type: "image/jpg")
boat.description = "Dessin au pastel dans un style de conte pour enfant de grande qualité d un navire à voile penché sur l eau par le vent, se déplaçant rapidement sur un ocean vert aux vagues formées. Une île aux hautes falaises est à peine visible dans la brume alors que le soleil se couche."
boat.save!

moon = Option.new(category: "Lieu", name: "La Lune")
moon.picture.attach(io: File.open("app/assets/images/moon_picture.jpg"), filename: "moon.jpg ", content_type: "image/jpg")
moon.description = "Dessin au pastel dans un style de conte pour enfant de grande qualité de la surface d une lune aménagée et peuplée de créatures diverses, étranges et amusantes dans leur habitat naturel."
moon.save!

puts "generate 6 items"

hat = Option.new(category: "Objet", name: "Chapeau")
hat.picture.attach(io: File.open("app/assets/images/hat_picture.jpg"), filename: "hat.jpg", content_type: "image/jpg")
hat.description = "Un grand et haut chapeau en feutre vert un peu mou, avec un bandeau en cuir, une clochette et des plumes rouges vif. Le chapeau est magique et a des pouvoirs mystérieux."
hat.save!

bubble_gun = Option.new(category: "Objet", name: "Pistobulle")
bubble_gun.picture.attach(io: File.open("app/assets/images/bubblegun_picture.jpg"), filename: "BubbleGun.jpg", content_type: "image/jpg")
bubble_gun.description = "Un pistolet à bulles pour enfant, on voit des bulles multicolores et irisées autour de l objet."
bubble_gun.save!

shirt = Option.new(category: "Objet", name: "Chemise")
shirt.picture.attach(io: File.open("app/assets/images/shirt_picture.jpg"), filename: "Shirt.jpg", content_type: "image/jpg")
shirt.description = "Une chemise unisexe pour enfant, avec des motifs multiples et bigarrés, flottant en l air au milieu d autres vetements magiques."
shirt.save!

sword = Option.new(category: "Objet", name: "Epée de feu")
sword.picture.attach(io: File.open("app/assets/images/sword_picture.jpg"), filename: "sword.jpg", content_type: "image/jpg")
sword.description = "Une epee-jouet animée et entourée de flammes bleues, dans une cave sombre recelant beaucoup d autres trésors étincelants."
sword.save!

crystal_ball = Option.new(category: "Objet", name: "Boule de cristal")
crystal_ball.picture.attach(io: File.open("app/assets/images/crystal_ball_picture.jpg"), filename: "crystalBall.jpg", content_type: "image/jpg")
crystal_ball.description = "Une boule de cristal brillante montrant un monde lointain, posée sur une table dans une pièce sombre chauffée par une grande cheminée."
crystal_ball.save!

stick = Option.new(category: "Objet", name: "Bâton magique")
stick.picture.attach(io: File.open("app/assets/images/stick_picture.jpg"), filename: "stick.jpg", content_type: "image/jpg")
stick.description = "Un baton de marche noueux et sec, surmonté d une poignée en corne. Il est posé sur une table basse dans une taverne enfumée. Le baton peut marcher et seul et guider son propriétaire."
stick.save!

puts "generate 2 voices"

# Emily's voice from Eleven Labs
voice = Voice.new(name: "Emily",
                  token: "LcfcDJNUP1GQjkzn1xUU")
voice.user = john
voice.audio.attach(io: File.open("app/assets/audio/emily_sample.mp3"), filename: "emily_sample.mp3", content_type: "audio")
voice.save!

# Thomas's voice from Eleven Labs
voice = Voice.new(name: "Thomas",
                  token: "GBv7mTt0atIp3Br8iCZE")
voice.user = john
voice.audio.attach(io: File.open("app/assets/audio/thomas_sample.mp3"), filename: "thomas_sample.mp3", content_type: "audio")
voice.save!

puts "generate 1 story"

story = Story.new(title: "La Princesse et l'Epée de Feu",
                  text: "Il était une fois une jeune Princesse courageuse vivant dans une petite cabane en lisière de la Forêt. Armée de son épée de feu magique, elle parcourait les sombres bois à la recherche d'aventures. Un jour, un dragon féroce bloqua son chemin, crachant des flammes menaçantes. La Princesse, sans hésitation, brandit son épée de feu qui brillait d'une lueur étincelante. Le dragon, ébloui par la lumière, s'enfuit à jamais. Reconnaissante, une licorne apparut et offrit son amitié à la Princesse. Ensemble, elles explorèrent la Forêt, découvrant ses secrets anciens et vivant mille et une aventures extraordinaires.",
                  options: [princesse, forest, sword],
                  prompts: "[\"Princesse courageuse affronte dragon féroce\", \"Epée de feu brille victorieusement\", \"Forêt mystérieuse cache secrets anciens\", \"Amitié avec licorne protectrice douce\"]",
                  playcount: 0,
                  is_favorite: false)
story.voice = voice
story.child = emma

story.pictures.attach(io: File.open("app/assets/images/princess_dragon.jpg"), filename: "dragon.jpg", content_type: "image/jpg")
story.pictures.attach(io: File.open("app/assets/images/princess_sword.jpg"), filename: "sword.jpg", content_type: "image/jpg")
story.pictures.attach(io: File.open("app/assets/images/princess_forest.jpg"), filename: "forest.jpg", content_type: "image/jpg")
story.pictures.attach(io: File.open("app/assets/images/princess_unicorn.jpg"), filename: "unicorn.jpg", content_type: "image/jpg")
story.audio.attach(io: File.open("app/assets/audio/story_sample.mp3"), filename: "blancheneige.mp3", content_type: "audio")
story.save!
