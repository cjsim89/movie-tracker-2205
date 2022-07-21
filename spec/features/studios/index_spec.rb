require "rails_helper" 

RSpec.describe "Studio Index" do
   
   describe "As a user" do
      describe "When I visit the studio index page" do
         it "I see each studio's name and location" do
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


            visit "/studios"
            expect(current_path).to eq("/studios")

            expect(page).to have_content("Studios")
            
            within("#studio-#{studio1.id}") do
               expect(page).to have_content("Lionsgate: California")
            end
            within("#studio-#{studio2.id}") do
               expect(page).to have_content("Lucasfilm: USA")
            end
            within("#studio-#{studio3.id}") do
               expect(page).to have_content("FOX: New York")
            end

         end

         it "Underneath that, I see the titles of all the studio's movies" do
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

            visit "/studios" 
            within("#studio-#{studio1.id}-movies") do
               expect(page).to have_content("John Wick\nRambo")
            end
            within("#studio-#{studio2.id}-movies") do
               expect(page).to have_content("Star Wars\nIndiana Jones")
            end
            within("#studio-#{studio3.id}-movies") do
               expect(page).to have_content("Family Guy The Movie\nAvatar\nIce Age")
            end

         end
      end
   end
end