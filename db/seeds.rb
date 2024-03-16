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
princesse.description = "Une elegante et jeune princesse malicieuse aux cheveux mi longs. Elle porte une robe violette et un diademe etincelant."
princesse.save!

patate = Option.new(category: "Personnage", name: "La Patate")
patate.picture.attach(io: File.open("app/assets/images/potato_picture.jpg"), filename: "patate.jpg", content_type: "image/jpg")
patate.description = "Une pomme de terre animee et boute en train, un peu ebouriffee, pleine d imagination et de reves ambitieux."
patate.save!

renard = Option.new(category: "Personnage", name: "Le Renard")
renard.picture.attach(io: File.open("app/assets/images/fox_picture.jpg"), filename: "renard.jpg", content_type: "image/jpg")
renard.description = "Un grand renard roux, elegant et mysterieux, avec de petits yeux expressifs."
renard.save!

lutin = Option.new(category: "Personnage", name: "Le Lutin")
lutin.picture.attach(io: File.open("app/assets/images/elf_picture.jpg"), filename: "lutin.jpg", content_type: "image/jpg")
lutin.description = "Un lutin malicieux equipe d une belle tenue verte et d un chapeau, prudent et patient pour atteindre ses objectifs."
lutin.save!

ninja = Option.new(category: "Personnage", name: "Le Ninja")
ninja.picture.attach(io: File.open("app/assets/images/ninja_picture.jpg"), filename: "ninja.jpg ", content_type: "image/jpg")
ninja.description = "Un ninja equipe d une tenue bleu nuit, silencieux, habile de ses mains et agile."
ninja.save!

ecoliere = Option.new(category: "Personnage", name: "L'Ecoliere")
ecoliere.picture.attach(io: File.open("app/assets/images/schoolgirl_picture.jpg"), filename: "ecoliere.jpg ", content_type: "image/jpg")
ecoliere.description = "Une ecoliere serieuse et enthousiaste. Elle porte un uniforme, un cartable et de petites lunettes."
ecoliere.save!

puts "generate 6 places"

forest = Option.new(category: "Lieu", name: "La Forêt")
forest.picture.attach(io: File.open("app/assets/images/forest_picture.jpg"), filename: "forest.jpg ", content_type: "image/jpg")
forest.description = "dans une foret luxuriante et magique, fourmillant de plantes et d animaux dissimules sous les feuilles et dans les branches."
forest.save!

underwater_city = Option.new(category: "Lieu", name: "La Mer")
underwater_city.picture.attach(io: File.open("app/assets/images/underwatercity_picture.jpg"), filename: "UnderwaterCity.jpg ", content_type: "image/jpg")
underwater_city.description = "dans une petite cite sous marine posee sur le sable, aux maisons et aux palais faits de coquillages, dont les habitants sont de petits poissons colores."
underwater_city.save!

castle = Option.new(category: "Lieu", name: "Le Château")
castle.picture.attach(io: File.open("app/assets/images/castle_picture.jpg"), filename: "castle.jpg ", content_type: "image/jpg")
castle.description = "dans un chateau fantastique, monumental et mysterieux, avec de nombreuses tours a creneaux, en pierre blanche et entoure par des champs a perte de vue."
castle.save!

mountain = Option.new(category: "Lieu", name: "La Montagne")
mountain.picture.attach(io: File.open("app/assets/images/mountain_picture.jpg"), filename: "mountain.jpg ", content_type: "image/jpg")
mountain.description = "sur une chaine de montagnes enneigees sous un ciel gris, avec des chemins, des grottes et de petits villages dissemines."
mountain.save!

boat = Option.new(category: "Lieu", name: "Le Bateau")
boat.picture.attach(io: File.open("app/assets/images/boat_picture.jpg"), filename: "boat.jpg ", content_type: "image/jpg")
boat.description = "dans un petit navire a voile tout en bois, ballotté par le vent, se deplaçant rapidement sur un ocean vert aux vagues formees."
boat.save!

moon = Option.new(category: "Lieu", name: "La Lune")
moon.picture.attach(io: File.open("app/assets/images/moon_picture.jpg"), filename: "moon.jpg ", content_type: "image/jpg")
moon.description = "sur une lune peuplee de creatures diverses, etranges et amusantes dans leur habitat naturel."
moon.save!

puts "generate 6 items"

hat = Option.new(category: "Objet", name: "Chapeau")
hat.picture.attach(io: File.open("app/assets/images/hat_picture.jpg"), filename: "hat.jpg", content_type: "image/jpg")
hat.description = "Un grand et haut chapeau en feutre vert un peu mou, avec un bandeau en cuir, une clochette et des plumes rouges vif. Le chapeau est magique et a des pouvoirs mysterieux"
hat.save!

bubble_gun = Option.new(category: "Objet", name: "Pistobulle")
bubble_gun.picture.attach(io: File.open("app/assets/images/bubblegun_picture.jpg"), filename: "BubbleGun.jpg", content_type: "image/jpg")
bubble_gun.description = "Un pistolet a bulles pour enfant, qui emet des bulles multicolores et irisees, qui eclatent en repandant du parfum et un peu de savon"
bubble_gun.save!

shirt = Option.new(category: "Objet", name: "Chemise")
shirt.picture.attach(io: File.open("app/assets/images/shirt_picture.jpg"), filename: "Shirt.jpg", content_type: "image/jpg")
shirt.description = "Une chemise unisexe pour enfant, avec des motifs multiples, bigarres et brillants, permettant a celui ou celle qui la porte de voler"
shirt.save!

sword = Option.new(category: "Objet", name: "Epée de feu")
sword.picture.attach(io: File.open("app/assets/images/sword_picture.jpg"), filename: "sword.jpg", content_type: "image/jpg")
sword.description = "Une epee jouet animee et entouree de flammes bleues, elle n est pas dangereuse mais peut servir a effrayer des mechants"
sword.save!

crystal_ball = Option.new(category: "Objet", name: "Boule de cristal")
crystal_ball.picture.attach(io: File.open("app/assets/images/crystal_ball_picture.jpg"), filename: "crystalBall.jpg", content_type: "image/jpg")
crystal_ball.description = "Une boule de cristal brillante dans laquelle on peut apercevoir un monde lointain et merveilleux "
crystal_ball.save!

stick = Option.new(category: "Objet", name: "Bâton magique")
stick.picture.attach(io: File.open("app/assets/images/stick_picture.jpg"), filename: "stick.jpg", content_type: "image/jpg")
stick.description = "Un baton de marche noueux et sec en bois sombre, fissure et surmonte d une poignee en corne. Il mesure pres d'un metre de haut"
stick.save!

puts "generate 2 voices"

# Emily's voice from Eleven Labs
emily_voice = Voice.new(name: "Emily",
                  token: "LcfcDJNUP1GQjkzn1xUU")
emily_voice.user = john
emily_voice.audio.attach(io: File.open("app/assets/audio/emily_sample.mp3"), filename: "emily_sample.mp3", content_type: "audio")
emily_voice.save!

# Thomas's voice from Eleven Labs
thomas_voice = Voice.new(name: "Thomas",
                  token: "GBv7mTt0atIp3Br8iCZE")
thomas_voice.user = john
thomas_voice.audio.attach(io: File.open("app/assets/audio/thomas_sample.mp3"), filename: "thomas_sample.mp3", content_type: "audio")
thomas_voice.save!

puts "generate 2 stories for Emma"

ecoliere_story = Story.new(title: "Le Courage de Noémie sur la Lune",
                  text: "Il était une fois une petite écolière nommée Noémie, une jeune fille sérieuse et enthousiaste qui aimait apprendre de nouvelles choses. Un jour, en rangeant son cartable, elle découvrit une étrange chemise recouverte de motifs colorés et brillants. En l'enfilant, Noémie sentit soudain une drôle de sensation et se mit à flotter doucement dans les airs. Sans peur, elle décida de s'envoler vers la Lune, peuplée de créatures éclectiques et rigolotes dans leur habitat naturel. Sur place, elle rencontra une petite magicienne timide en pleurs, ayant perdu son précieux balai magique. Malgré sa propre appréhension, Noémie décida de l'aider. Ensemble, elles entreprirent un incroyable voyage rempli de défis farfelus. Guidées par la boussole enchantée de la magicienne, elles traversèrent des plaines de poussière d'étoiles scintillantes et des montagnes de fromage. Grâce à leur courage et leur ingéniosité, elles surmontèrent chaque obstacle avec bravoure. Enfin, après maintes péripéties, Noémie et la magicienne retrouvèrent le balai magique, déclenchant ainsi la reconnaissance et la gratitude de la magicienne. Cette dernière leur offrit alors un dernier cadeau : un voyage en tapis volant, les ramenant sur Terre, des étoiles plein les yeux, prêtes à vivre de nouvelles aventures extraordinaires.",
                  options: [ecoliere, moon, shirt],
                  prompts: "[\"Noémie, l'écolière sérieuse et enthousiaste, enfile sa chemise magique couverte de motifs colorés et brillants. Elle sent soudain une sensation de légèreté et s'envole dans les airs, direction la Lune peuplée de créatures étranges et amusantes.\", \"Sur la Lune, Noémie rencontre une petite magicienne timide qui a perdu son balai magique. Malgré sa peur, Noémie décide de l'aider à le retrouver pour qu'elle puisse rentrer chez elle. Ensemble, elles affrontent des défis étonnants et rigolos.\", \"Guidées par la boussole enchantée de la magicienne, Noémie et son amie traversent des plaines de poussière d'étoiles scintillantes et des montagnes de fromage. Elles doivent parfois résoudre des énigmes farfelues pour avancer.\", \"Finalement, après une longue aventure pleine de courage et d'entraide, Noémie et la magicienne retrouvent le balai magique. La magicienne reconnaissante les remercie et leur offre un voyage en tapis volant pour rentrer sur Terre, des étoiles plein les yeux.\"]",
                  playcount: 0,
                  is_favorite: false)
ecoliere_story.voice = emily_voice
ecoliere_story.child = emma

ecoliere_story.pictures.attach(io: File.open("app/assets/images/noemie1.jpg"), filename: "n1.jpg", content_type: "image/jpg")
ecoliere_story.pictures.attach(io: File.open("app/assets/images/noemie2.jpg"), filename: "n2.jpg", content_type: "image/jpg")
ecoliere_story.pictures.attach(io: File.open("app/assets/images/noemie3.jpg"), filename: "n3.jpg", content_type: "image/jpg")
ecoliere_story.audio.attach(io: File.open("app/assets/audio/ecoliere_story.mp3"), filename: "ecoliere_story.mp3", content_type: "audio")
ecoliere_story.save!

lutin_story = Story.new(title: "Les Aventures de Léo le Lutin et Pistobulle",
                  text: "Léo le Lutin était un jeune lutin malicieux vêtu d'une belle tenue verte et coiffé d'un chapeau pointu. Il vivait dans une petite cité sous-marine posée sur le sable de La Mer, où les maisons et les palais étaient faits de coquillages et où les habitants étaient de petits poissons colorés. Un jour, un grand défi s'est présenté à Léo : des algues géantes ont commencé à envahir la cité sous-marine, menaçant de tout recouvrir. Léo savait qu'il devait agir vite pour sauver son foyer. Avec l'aide de son fidèle compagnon, le chat volant Pistobulle, Léo s'est mis à réfléchir à un plan ingénieux pour se débarrasser des algues. Ensemble, ils ont trouvé une solution : les bulles multicolores de Pistobulle se sont transformées en petites créatures marines qui ont dévoré les algues géantes, sauvant ainsi la cité sous-marine de la catastrophe. Grâce à Pistobulle et à sa réflexion, Léo le Lutin a surmonté ce défi avec succès, montrant ainsi l'importance de la réflexion et de la résolution des problèmes.",
                  options: [lutin, underwater_city, bubble_gun],
                  prompts: "[\"Léo le Lutin se promène le long de la plage de coquillages de la cité sous-marine. Il observe les petits poissons colorés qui nagent joyeusement entre les coraux et les algues.\", \"Un jour, un grand défi se présente à Léo : des algues géantes envahissent la cité sous-marine et menacent de tout recouvrir. Il sait qu'il doit agir rapidement pour sauver son foyer.\", \"Avec l'aide de son fidèle compagnon, le chat volant Pistobulle, Léo se met à réfléchir à un plan ingénieux pour se débarrasser des algues. Ensemble, ils trouvent une solution qui pourrait bien sauver la cité sous-marine.\", \"Grâce à Pistobulle et à sa réflexion, Léo le Lutin parvient à mettre en œuvre son plan. Les bulles multicolores de Pistobulle se transforment en petites créatures marines qui dévorent les algues géantes, sauvant ainsi la cité sous-marine de la catastrophe.\"]",
                  playcount: 1,
                  is_favorite: false)
lutin_story.voice = thomas_voice
lutin_story.child = emma

lutin_story.pictures.attach(io: File.open("app/assets/images/leo1.jpg"), filename: "leo1.jpg", content_type: "image/jpg")
lutin_story.pictures.attach(io: File.open("app/assets/images/leo2.jpg"), filename: "leo2.jpg", content_type: "image/jpg")
lutin_story.pictures.attach(io: File.open("app/assets/images/leo3.jpg"), filename: "leo3.jpg", content_type: "image/jpg")
lutin_story.pictures.attach(io: File.open("app/assets/images/leo4.jpg"), filename: "leo4.jpg", content_type: "image/jpg")
lutin_story.audio.attach(io: File.open("app/assets/audio/lutin_story.mp3"), filename: "lutin_story.mp3", content_type: "audio")
lutin_story.save!


puts "generate 1 story for Matheo"

princesse_story = Story.new(title: "Le Courage de Camille",
                  text: "Il était une fois, dans un château majestueux, une jeune Princesse nommée Camille. Elle avait de longs cheveux bruns et portait une magnifique robe violette. Sa plus grande qualité était le courage, même si elle était souvent discrète. Un jour, en se promenant dans les jardins du château, la Princesse Camille entendit un appel au secours provenant de la forêt. Sans hésiter, elle décida d'aller voir ce qui se passait. Là-bas, elle trouva un petit écureuil coincé dans un piège. Avec courage, elle parvint à libérer l'animal. Reconnaissant, l'écureuil la remercia avant de disparaître. Peu de temps après, un dragon surgit devant elle, crachant des flammes. La Princesse sortit sa boule de cristal et murmura une formule magique. La boule se mit à briller intensément, effrayant le dragon qui prit la fuite. De retour au château, tous acclamèrent la bravoure de la Princesse Camille. Elle avait montré que même les plus discrets pouvaient être courageux et accomplir de grandes choses.",
                  options: [princesse, castle, crystal_ball],
                  prompts: "[\"Un jour, la Princesse Camille se promène dans les jardins du château lorsqu'elle entend un appel au secours provenant de la forêt. Malgré sa peur, elle décide d'aller voir ce qui se passe.\", \"Dans la forêt sombre, la Princesse Camille découvre un écureuil coincé dans un piège sournois. Avec courage, elle parvient à ouvrir le piège et libérer l'écureuil, qui la remercie d'un petit signe de tête avant de s'enfuir.\", \"Soudain, un dragon terrifiant apparaît devant la Princesse Camille, crachant des flammes. Sans hésiter, elle sort sa boule de cristal et murmure quelques mots magiques. La boule se met à briller intensément, effrayant le dragon qui s'enfuit à toute vitesse.\", \"De retour au château, la Princesse Camille est acclamée par tous pour son courage. Elle sait désormais que même les plus petites créatures peuvent avoir un grand impact grâce à leur discrétion.\"]",
                  playcount: 1,
                  is_favorite: false)
princesse_story.voice = thomas_voice
princesse_story.child = matheo

princesse_story.pictures.attach(io: File.open("app/assets/images/camille1.jpg"), filename: "c1.jpg", content_type: "image/jpg")
princesse_story.pictures.attach(io: File.open("app/assets/images/camille2.jpg"), filename: "c2.jpg", content_type: "image/jpg")
princesse_story.pictures.attach(io: File.open("app/assets/images/camille3.jpg"), filename: "c3.jpg", content_type: "image/jpg")
princesse_story.pictures.attach(io: File.open("app/assets/images/camille4.jpg"), filename: "c4.jpg", content_type: "image/jpg")
princesse_story.audio.attach(io: File.open("app/assets/audio/princesse_story.mp3"), filename: "princesse_story.mp3", content_type: "audio")
princesse_story.save!
