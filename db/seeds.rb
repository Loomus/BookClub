# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Book.destroy_all
Author.destroy_all
Review.destroy_all
User.destroy_all
# All Books

pillars = Book.create!(title: "Pillars of the Earth", pages: 1018 , year: 1989 , cover_image: "https://images.penguinrandomhouse.com/cover/9780451488336")
devil = Book.create!(title: "The Devil in the White City", pages: 466, year: 2003, cover_image: "https://images-na.ssl-images-amazon.com/images/I/91nh%2BRL7nPL.jpg")
mockingbird = Book.create!(title: "To Kill a Mockingbird", pages: 399, year: 1960, cover_image: "https://cdn.britannica.com/s:500x350/21/182021-004-532121B3.jpg")
jurassic = Book.create!(title: "Jurassic Park", pages: 408, year: 1990, cover_image: "https://images-na.ssl-images-amazon.com/images/I/81rBVCDfrgL.jpg")
moby_dick = Book.create!(title: "Moby Dick or The Whale", pages: 585, year: 1987, cover_image: "https://ih1.redbubble.net/image.357380061.5193/pp,550x550.u2.jpg")
sphere = Book.create!(title: "Sphere", pages: 382, year: 1987, cover_image: "https://i.harperapps.com/covers/9780062428868/x510.jpg")
pittsburgh = Book.create!(title: "The Mysteries of Pittsburgh", pages: 340, year: 1988, cover_image: "https://globalbookclub.s3.amazonaws.com/resources/686403/the_mysteries_of_pittsburgh/cover.jpg")
lotr_1 = Book.create!(title: "The Fellowship of the Ring", pages: 561, year: 1954, cover_image: "https://prodimage.images-bn.com/pimages/9780547928210_p0_v2_s550x406.jpg")
lotr_2 = Book.create!(title: "The Two Towers", pages: 352, year: 1954, cover_image: "https://prodimage.images-bn.com/pimages/9780547928203_p0_v2_s1200x630.jpg")
lotr_3 = Book.create!(title: "The Return of the King", pages: 460, year: 1955, cover_image: "https://images-na.ssl-images-amazon.com/images/I/41KGl2FqeAL.jpg")
unearthed = Book.create!(title: "Unearthed", pages: 436, year: 2018, cover_image: "https://images.gr-assets.com/books/1495338003l/32941343.jpg")
omens = Book.create!(title: "Good Omens", pages: 434, year: 1990, cover_image: "https://images-na.ssl-images-amazon.com/images/I/8167H8DUjnL.jpg")
creatures = Book.create!(title: "Beautiful Creatures", pages: 563, year: 2009, cover_image: "https://img1.od-cdn.com/ImageType-400/4575-1/FB5/05C/BF/%7BFB505CBF-F575-4CF0-9041-BF6108D2F5E9%7DImg400.jpg")
talisman = Book.create!(title: "The Talisman", pages: 921, year: 1984, cover_image: "https://images-na.ssl-images-amazon.com/images/I/61kV5uyiunL.jpg")
sematary = Book.create!(title: "Pet Sematary", pages: 374, year: 1983, cover_image: "https://prodimage.images-bn.com/pimages/9781982115982_p0_v3_s550x406.jpg")

# All authors

ken_follet = pillars.authors.create!(name: "Ken Follett")
erik_larson = devil.authors.create!(name: "Erik Larson")
harper = mockingbird.authors.create!(name: "Harper Lee")
herman = moby_dick.authors.create!(name: "Herman Melville")
chabon = pittsburgh.authors.create!(name: "Michael Chabon")
michael_chrichton = Author.create!(name: "Michael Chrichton")
tolkien = Author.create!(name: "J.R.R Tolkien")
kaufman = Author.create!(name: "Amie Kaufman")
spooner = Author.create!(name: "Megan Spooner")
terry = Author.create!(name: "Terry Pratchett")
neil = Author.create!(name: "Neil Gaiman")
kami = Author.create!(name: "Kami Garcia")
margaret = Author.create!(name: "Margaret Stohl")
stephen = Author.create!(name: "Stephen King")
peter = Author.create!(name: "Peter Straub")

# Multiple Associations

michael_chrichton.books << jurassic
michael_chrichton.books << sphere
tolkien.books << lotr_1
tolkien.books << lotr_2
tolkien.books << lotr_3
kaufman.books << unearthed
spooner.books << unearthed
terry.books << omens
neil.books << omens
kami.books << creatures
margaret.books << creatures
stephen.books << sematary
stephen.books << talisman
peter.books << talisman

#users

user_1 = User.create!(name: "Grey Worm")
user_2 = User.create!(name: "Daenerys")
user_3 = User.create!(name: "Tyrion")
user_4 = User.create!(name: "Varys")
user_5 = User.create!(name: "John Snow")
user_6 = User.create!(name: "Cercei")
user_7 = User.create!(name: "Jaime")
user_8 = User.create!(name: "Arya")
user_9 = User.create!(name: "The Mountain")
user_10 = User.create!(name: "The Hound")
user_11 = User.create!(name: "Brienne")
user_11 = User.create!(name: "Theon")
user_12 = User.create!(name: "Khal")
# reviews

review_1 = Review.create!(title: "Pillars review 1", rating: 5, description: "Great book, compelling read", book: pillars, user: user_1)
review_2 = Review.create!(title: "Pillars review 2", rating: 4, description: "I liked this book a lot", book: pillars, user: user_2)
review_3 = Review.create!(title: "Pillars review 3" ,rating: 5 ,description: "Very good book", book: pillars, user: user_3)

review_3 = Review.create!(title: "Devil review 1" ,rating: 4 ,description: "Pretty good book", book: devil, user: user_1)
review_4 = Review.create!(title: "Devil review 2" ,rating: 4 ,description: "Almost a great book" ,book: devil, user: user_2)
review_5 = Review.create!(title: "Devil review 3" ,rating: 5 ,description: "That was a great book", book: devil, user: user_9)
review_6 = Review.create!(title: "Devil review 4" ,rating: 4 ,description: "Pretty good, well done", book: devil, user: user_4)


review_7 = Review.create!(title: "Mockingbird review 1" ,rating: 3 ,description: "Pretty good, kinda boring though", book: mockingbird ,user: user_1)

review_8 = Review.create!(title: "Jurassic review 1" ,rating: 2 ,description: "I didn't like it, i'm afraid of dinosaurs", book: jurassic ,user: user_5)

review_9 = Review.create!(title: "moby dick review 1" ,rating: 1 ,description: "This book was a book" ,book: moby_dick, user: user_1)

review_10 = Review.create!(title: "Pet Sematary review 1" ,rating: 2 ,description: "Very disturbing" ,book: sematary, user: user_5)
review_11 = Review.create!(title: "Pet Sematary review 2" ,rating: 5 ,description: "This book is not as good as the shining.", book: sematary, user: user_6)
review_12 = Review.create!(title: "Pet Sematary review 3" ,rating: 2 ,description: "Very relatable and down to earth.", book: sematary, user: user_7)
review_13 = Review.create!(title: "Pet Sematary review 4" ,rating: 3 ,description: "I am neutral in my opinion of this book. I neither enjoyed it nor disliked it.", book: sematary, user: user_8)

review_14 = Review.create!(title: "Talisman Review 1" ,rating: 1 ,description: "Wow, my life is forever changed after that riveting experience.", book: talisman, user: user_2)
review_15 = Review.create!(title: "Talisman Review 2" ,rating: 4 ,description: "This book has reminded me to never give up.", book: talisman ,user: user_11)
review_16 = Review.create!(title: "Talisman Review 3" ,rating: 3 ,description: "I am so glad I read this book, I would highly recommend it.", book: talisman, user: user_10)
review_17 = Review.create!(title: "Talisman Review 4" ,rating: 5 ,description: "Too much words and stuff.", book: talisman, user: user_8)
review_18 = Review.create!(title: "Talisman Review 5" ,rating: 2 ,description: "I normally don't like stephen king novels, but this one was pretty good.", book: talisman, user: user_9)

review_19 = Review.create!(title: "Towers Review" ,rating: 2 ,description: "Is this a true story?", book: lotr_2, user: user_4)
review_20 = Review.create!(title: "Towers is my favorite" ,rating: 5 ,description: "The book is way better than the movie", book: lotr_2, user: user_1)

review_21 = Review.create!(title: "Sphere Review 1" ,rating: 3 ,description: "The book is pretty cool", book: sphere, user: user_11)
review_22 = Review.create!(title: "Sphere Review 2" ,rating: 4 ,description: "I loved reading this", book: sphere, user: user_9)
review_23 = Review.create!(title: "Sphere Review 3" ,rating: 5 ,description: "The book is way too philosophical", book: sphere, user: user_6)

review_23 = Review.create!(title: "Pittsburgh review 1" ,rating: 5 ,description: "Very good, couldn't put it down.", book: pittsburgh, user: user_7)
review_24 = Review.create!(title: "Pittsburgh review 2" ,rating: 4 ,description: "Characters are well developed.", book: pittsburgh, user: user_3)
review_25 = Review.create!(title: "Pittsburgh review 3" ,rating: 3 ,description: "Book was ok, I prefered sphere.", book: pittsburgh, user: user_6)
review_26 = Review.create!(title: "Pittsburgh review 4" ,rating: 5 ,description: "Very well done", book: pittsburgh, user: user_8)


review_27 = Review.create!(title: "Good Omens Review 1" ,rating: 5 ,description: "Very well done, captivating til the very end.", book: omens, user: user_10)
review_28 = Review.create!(title: "Good Omens Review 2" ,rating: 2 ,description: "Left much to be desired", book: omens, user: user_5)
review_29 = Review.create!(title: "Good Omens Review 3" ,rating: 1 ,description: "Terrible, complete waste of time", book: omens, user: user_11)


review_30 = Review.create!(title: "Beautiful Creatures Review 1" ,rating: 2 ,description: "This book was hot garbage.", book: creatures, user: user_4)
review_31 = Review.create!(title: "Beautiful Creatures Review 2" ,rating: 3 ,description: "Could be better, too much dialogue, not enough action.", book: creatures, user: user_2)
review_32 = Review.create!(title: "Beautiful Creatures Review 3" ,rating: 4 ,description: "I enjoyed it, and my friends did aswell, cannot wait for the sequel", book: creatures, user: user_11)
review_33 = Review.create!(title: "Beautiful Creatures Review 4" ,rating: 5 ,description: "One of the best books I have ever read.", book: creatures, user: user_9)

review_34 = Review.create!(title: "Pillars review 4" ,rating: 4 ,description: "Very good book, just needed more sword fighting.", book: pillars, user: user_8)
review_35 = Review.create!(title: "Pillars review 5" ,rating: 3 ,description: "Awesome! cant wait to read his next one", book: pillars, user: user_4)
review_36 = Review.create!(title: "Pillars review 6" ,rating: 4 ,description: "Very good book, just needed more sword fighting.", book: pillars, user: user_7)
review_37 = Review.create!(title: "Pillars review 7" ,rating: 5 ,description: "Very good book, just needed more sword fighting.", book: pillars, user: user_11)
review_38 = Review.create!(title: "Pillars review 8" ,rating: 4 ,description: "Very good book, just needed more sword fighting.", book: pillars, user: user_6)
review_39 = Review.create!(title: "Pillars review 9" ,rating: 4 ,description: "Very good book, just needed more sword fighting.", book: pillars, user: user_5)
