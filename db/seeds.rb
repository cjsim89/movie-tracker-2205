# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([( name: 'Star Wars' ), ( name: 'Lord of the Rings' )])
#   Character.create(name: 'Luke', movie: movies.first)
Studio.destroy_all
Actor.destroy_all
Movie.destroy_all
ActorsMovies.destroy_all


studio1 = Studio.create!(name: "Lionsgate", location: "California")
studio2 = Studio.create!(name: "Lucasfilm", location: "USA")
studio3 = Studio.create!(name: "FOX", location: "New York")

johnwick = studio1.movies.create!(title: "John Wick", creation_year: 2009, genre: "Adventure")
rambo = studio1.movies.create!(title: "Rambo", creation_year: 1989, genre: "Action")
starwars = studio2.movies.create!(title: "Star Wars", creation_year: 1977, genre: "Sci Fi")
indianajones = studio2.movies.create!(title: "Indiana Jones", creation_year: 1982, genre: "Sci Fi Adventure")
familyguy = studio3.movies.create!(title: "Family Guy The Movie", creation_year: 2011, genre: "Animated")
avatar = studio3.movies.create!(title: "Avatar", creation_year: 2009, genre: "Who knows")
iceage = studio3.movies.create!(title: "Ice Age", creation_year: 2002, genre: "Animated")

harrisonford = Actor.create!(name: "Harrison Ford", age: 75)
carriefisher = Actor.create!(name: "Carrie Fisher", age: 65)
sw = Actor.create!(name: "Sam Worthington", age: 35)
sigw = Actor.create!(name: "Sigourney Weaver", age: 77)
sm = Actor.create!(name: "Seth McFarlane", age: 42)
actor = Actor.create!(name: "Actor Face", age: 99)

ActorsMovies.create!(actor: harrisonford, movie: starwars)
ActorsMovies.create!(actor: harrisonford, movie: indianajones)
ActorsMovies.create!(actor: carriefisher, movie: starwars)
ActorsMovies.create!(actor: sw, movie: avatar)
ActorsMovies.create!(actor: sm, movie: familyguy)
ActorsMovies.create!(actor: actor, movie: iceage)