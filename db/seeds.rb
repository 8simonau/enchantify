puts "generate one user and 5 children"


john = User.create(first_name: "John", last_name: "Father", email: "john@mail.com", password: "123456")

file = URI.open("https://as1.ftcdn.net/v2/jpg/02/84/51/00/1000_F_284510053_9EA7vNLlgeZajPOMzaToA8gAOqgDWDtW.jpg")
emma = Child.new(first_name: "Emma", birth_date: "01/05/2018", story_duration: 120)
emma.avatar.attach(io: file, filename: "emma.png", content_type: "image/png")
emma.user = john
emma.save!

file = URI.open("http://res.cloudinary.com/dgwpmqnpb/image/upload/v1708178307/etbpakkldejndkclevc6.jpg")
matheo = Child.new(first_name: "Matheo", birth_date: "01/05/2015", story_duration: 90)
matheo.avatar.attach(io: file, filename: "matheo.png", content_type: "image/png")
matheo.user = john
matheo.save!

file = URI.open("http://res.cloudinary.com/dgwpmqnpb/image/upload/v1708178320/haxzqww2e42mnhc9wvpc.jpg")
mike = Child.new(first_name: "Mike", birth_date: "03/03/2020", story_duration: 60)
mike.avatar.attach(io: file, filename: "mike.png", content_type: "image/png")
mike.user = john
mike.save!

file = URI.open("http://res.cloudinary.com/dgwpmqnpb/image/upload/v1708178346/bay4as0qwf6hrwbigqpf.jpg")
joelle = Child.new(first_name: "Joelle", birth_date: "01/01/2017", story_duration: 100)
joelle.avatar.attach(io: file, filename: "joelle.png", content_type: "image/png")
joelle.user = john
joelle.save!

file = URI.open("http://res.cloudinary.com/dgwpmqnpb/image/upload/v1708178334/rqar9rgs4ssuwgp65xry.jpg")
yann = Child.new(first_name: "Yann", birth_date: "01/10/2020", story_duration: 50)
yann.avatar.attach(io: file, filename: "yann.png", content_type: "image/png")
yann.user = john
yann.save!

puts "generate 5 characters"

option = Option.new(category: "Character", name: "Masky")
file = URI.open("https://res.cloudinary.com/dgwpmqnpb/image/upload/v1708028830/odr4dmydpyeyvoyewkqi.png")
option.picture.attach(io: file, filename: "masky.png", content_type: "image/png")
option.save!

option = Option.new(category: "Character", name: "Meyrius")
file = URI.open("https://res.cloudinary.com/dgwpmqnpb/image/upload/v1708028880/jfzpi18qlautov7qcymd.png")
option.picture.attach(io: file, filename: "meyrius.png", content_type: "image/png")
option.save!

option = Option.new(category: "Character", name: "Ginella")
file = URI.open("http://res.cloudinary.com/dgwpmqnpb/image/upload/v1708028928/lyicsxdc5mqjo57fvjjx.png")
option.picture.attach(io: file, filename: "ginella.png", content_type: "image/png")
option.save!

option = Option.new(category: "Character", name: "Fatrinz")
file = URI.open("https://res.cloudinary.com/dgwpmqnpb/image/upload/v1708167735/g6ipyvatthludfpntvbr.png")
option.picture.attach(io: file, filename: "fatrinz.png", content_type: "image/png")
option.save!

option = Option.new(category: "Character", name: "Billensa")
file = URI.open("http://res.cloudinary.com/dgwpmqnpb/image/upload/v1708029006/wfqkbuscvadkgckxmg8l.png")
option.picture.attach(io: file, filename: "billensa.png ", content_type: "image/png")
option.save!

puts "generate 5 places"

option = Option.new(category: "Place", name: "Forest")
file = URI.open("https://res.cloudinary.com/dgwpmqnpb/image/upload/v1708167809/zuyhhsmerzfcmw7lce4a.png")
option.picture.attach(io: file, filename: "forest.png ", content_type: "image/png")
option.save!

option = Option.new(category: "Place", name: "Castle")
file = URI.open("https://res.cloudinary.com/dgwpmqnpb/image/upload/v1708167790/ufzknjn37mihendhzcb3.png")
option.picture.attach(io: file, filename: "castle.png ", content_type: "image/png")
option.save!

option = Option.new(category: "Place", name: "Boat")
file = URI.open("http://res.cloudinary.com/dgwpmqnpb/image/upload/v1708171377/gimmhnjepc2hxxa33ojl.png")
option.picture.attach(io: file, filename: "Boat.png ", content_type: "image/png")
option.save!

option = Option.new(category: "Place", name: "Underwatercity")
file = URI.open("http://res.cloudinary.com/dgwpmqnpb/image/upload/v1708171508/u3zum8at4biaysfkv4zm.png")
option.picture.attach(io: file, filename: "Underwatercity.png ", content_type: "image/png")
option.save!

option = Option.new(category: "Place", name: "Space")
file = URI.open("http://res.cloudinary.com/dgwpmqnpb/image/upload/v1708171508/u3zum8at4biaysfkv4zm.png")
option.picture.attach(io: file, filename: "Space.png ", content_type: "image/png")
option.save!

puts "generate 4 items"

option = Option.new(category: "Item", name: "Sword")
file = URI.open("http://res.cloudinary.com/dgwpmqnpb/image/upload/v1708171486/c8jqi8kfyrsgchsaryfw.png")
option.picture.attach(io: file, filename: "sword.png ", content_type: "image/png")
option.save!

option = Option.new(category: "Item", name: "Bubblegun")
file = URI.open("http://res.cloudinary.com/dgwpmqnpb/image/upload/v1708171423/u6bimv63urtk6vvlhp9s.png")
option.picture.attach(io: file, filename: "Bubblegun.png ", content_type: "image/png")
option.save!

option = Option.new(category: "Item", name: "Dress")
file = URI.open("http://res.cloudinary.com/dgwpmqnpb/image/upload/v1708171457/rukpqmlttgvr54vkkgmd.png")
option.picture.attach(io: file, filename: "Dress.png ", content_type: "image/png")
option.save!

option = Option.new(category: "Item", name: "Hat")
file = URI.open("https://res.cloudinary.com/dgwpmqnpb/image/upload/v1708167771/thkod1ov9zpdclm8axbp.png")
option.picture.attach(io: file, filename: "HAT.png ", content_type: "image/png")
option.save!

puts "generate 1 voice"

voice = Voice.new(name: "default",
                  token: "21m00Tcm4TlvDq8ikWAM")
voice.user = john
voice.save!

puts "generate 1 story"

story = Story.new(title: "Blanche-Neige",
                  text: "Un jour de plein hiver, une reine était assise à sa fenêtre encadrée de bois d'ébène et cousait. Tout en tirant l'aiguille, elle regardait voler les blancs flocons. Elle se piqua au doigt et trois gouttes de sang tombèrent sur la neige. Ce rouge sur ce blanc faisait si bel effet qu'elle se dit : « Si seulement j'avais un enfant aussi blanc que la neige, aussi rose que le sang, aussi noir que le bois de ma fenêtre ! » Peu de temps après, une fille lui naquit ; elle était blanche comme neige, rose comme sang et ses cheveux étaient noirs comme de l'ébène. On l'appela Blanche-Neige.",
                  playcount: 0,
                  is_favorite: false)
story.voice = voice
story.child = emma

file = URI.open("https://res.cloudinary.com/dgwpmqnpb/video/upload/v1708030579/zg3tda0dtlijjf6czscy.mp3")
story.audio.attach(io: file, filename: "blancheneige.mp3", content_type: "audio")
story.save!
