# generate one user and one child

file = URI.open("https://as1.ftcdn.net/v2/jpg/02/84/51/00/1000_F_284510053_9EA7vNLlgeZajPOMzaToA8gAOqgDWDtW.jpg")
john = User.create(first_name: "John", last_name: "Father", email: "john@mail.com", password: "123456")
emma = Child.new(first_name: "Emma", birth_date: "01/05/2018", story_duration: 120)
emma.avatar.attach(io: file, filename: "emma.jpg", content_type: "image/jpg")
emma.user = john
emma.save

# generate 5 characters

option = Option.new(category: "Character", name: "Masky")
file = URI.open("https://res.cloudinary.com/dgwpmqnpb/image/upload/v1708028830/odr4dmydpyeyvoyewkqi.png")
option.picture.attach(io: file, filename: "masky.png", content_type: "image/png")
option.save

option = Option.new(category: "Character", name: "Meyrius")
file = URI.open("https://res.cloudinary.com/dgwpmqnpb/image/upload/v1708028880/jfzpi18qlautov7qcymd.png")
option.picture.attach(io: file, filename: "meyrius.png", content_type: "image/png")
option.save

option = Option.new(category: "Character", name: "Ginella")
file = URI.open("http://res.cloudinary.com/dgwpmqnpb/image/upload/v1708028928/lyicsxdc5mqjo57fvjjx.png")
option.picture.attach(io: file, filename: "ginella.png", content_type: "image/png")
option.save

option = Option.new(category: "Character", name: "Fatrinz")
file = URI.open("http://res.cloudinary.com/dgwpmqnpb/image/upload/v1708028982/jcgbg4d3uiomuojm9nbv.png")
option.picture.attach(io: file, filename: "fatrinz.png", content_type: "image/png")
option.save

option = Option.new(category: "Character", name: "Billensa")
file = URI.open("http://res.cloudinary.com/dgwpmqnpb/image/upload/v1708029006/wfqkbuscvadkgckxmg8l.png")
option.picture.attach(io: file, filename: "billensa.png", content_type: "image/png")
option.save

# generate places

# generate objects

# generate 1 story
story = Story.new(title: "Blanche-Neige",
                  text: "Un jour de plein hiver, une reine était assise à sa fenêtre encadrée de bois d'ébène et cousait. Tout en tirant l'aiguille, elle regardait voler les blancs flocons. Elle se piqua au doigt et trois gouttes de sang tombèrent sur la neige. Ce rouge sur ce blanc faisait si bel effet qu'elle se dit : « Si seulement j'avais un enfant aussi blanc que la neige, aussi rose que le sang, aussi noir que le bois de ma fenêtre ! » Peu de temps après, une fille lui naquit ; elle était blanche comme neige, rose comme sang et ses cheveux étaient noirs comme de l'ébène. On l'appela Blanche-Neige.")
story.child = emma

file = URI.open("https://res.cloudinary.com/dgwpmqnpb/video/upload/v1708030579/zg3tda0dtlijjf6czscy.mp3")
story.audio.attach(io: file, filename: "blancheneige.mp3", content_type: "audio")
story.save
