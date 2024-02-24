puts "generate one user and 5 children"


john = User.create(first_name: "John", last_name: "Father", email: "john@mail.com", password: "123456", admin: true)

emma = Child.new(first_name: "Emma", birth_date: "01/05/2018", story_duration: 120)
emma.avatar.attach(io: File.open("app/assets/images/emma_picture.jpg"), filename: "emma.png", content_type: "image/png")
emma.user = john
emma.save!

matheo = Child.new(first_name: "Matheo", birth_date: "01/05/2015", story_duration: 90)
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

option = Option.new(category: "Character", name: "Princesse")
file = URI.open("https://res.cloudinary.com/dgwpmqnpb/image/upload/v1708028830/odr4dmydpyeyvoyewkqi.png")
option.picture.attach(io: file, filename: "princesse.png", content_type: "image/png")
option.save!

option = Option.new(category: "Character", name: "Patate")
file = URI.open("https://res.cloudinary.com/dgwpmqnpb/image/upload/v1708028880/jfzpi18qlautov7qcymd.png")
option.picture.attach(io: file, filename: "patate.png", content_type: "image/png")
option.save!

option = Option.new(category: "Character", name: "Renard")
file = URI.open("http://res.cloudinary.com/dgwpmqnpb/image/upload/v1708028928/lyicsxdc5mqjo57fvjjx.png")
option.picture.attach(io: file, filename: "renard.png", content_type: "image/png")
option.save!

option = Option.new(category: "Character", name: "Lutin")
file = URI.open("https://res.cloudinary.com/dgwpmqnpb/image/upload/v1708167735/g6ipyvatthludfpntvbr.png")
option.picture.attach(io: file, filename: "lutin.png", content_type: "image/png")
option.save!

option = Option.new(category: "Character", name: "Paysanne")
file = URI.open("http://res.cloudinary.com/dgwpmqnpb/image/upload/v1708029006/wfqkbuscvadkgckxmg8l.png")
option.picture.attach(io: file, filename: "paysanne.png ", content_type: "image/png")
option.save!

puts "generate 4 places"

option = Option.new(category: "Place", name: "Forest")
option.picture.attach(io: File.open("app/assets/images/forest_picture.png"), filename: "forest.png ", content_type: "image/png")
option.save!

option = Option.new(category: "Place", name: "Castle")
option.picture.attach(io: File.open("app/assets/images/castle_picture.png"), filename: "castle.png ", content_type: "image/png")
option.save!

option = Option.new(category: "Place", name: "Boat")
option.picture.attach(io: File.open("app/assets/images/boat_picture.png"), filename: "Boat.png ", content_type: "image/png")
option.save!

option = Option.new(category: "Place", name: "Underwater City")
option.picture.attach(io: File.open("app/assets/images/underwatercity_picture.png"), filename: "UnderwaterCity.png ", content_type: "image/png")
option.save!

puts "generate 4 items"

option = Option.new(category: "Item", name: "Hat")
option.picture.attach(io: File.open("app/assets/images/hat_picture.png"), filename: "hat.png", content_type: "image/png")
option.save!

option = Option.new(category: "Item", name: "Bubble Gun")
option.picture.attach(io: File.open("app/assets/images/bubblegun_picture.png"), filename: "BubbleGun.png", content_type: "image/png")
option.save!

option = Option.new(category: "Item", name: "Dress")
option.picture.attach(io: File.open("app/assets/images/dress_picture.png"), filename: "Dress.png", content_type: "image/png")
option.save!

option = Option.new(category: "Item", name: "Sword")
option.picture.attach(io: File.open("app/assets/images/sword_picture.png"), filename: "sword.png", content_type: "image/png")
option.save!

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
                  options: [Option.last, Option.first, Option.find_by_name("Forest")],
                  prompts: "['beginning', 'danger', 'victory']",
                  playcount: 0,
                  is_favorite: false)
story.voice = voice
story.child = emma

story.audio.attach(io: File.open("app/assets/audio/story_sample.mp3"), filename: "blancheneige.mp3", content_type: "audio")
story.save!
