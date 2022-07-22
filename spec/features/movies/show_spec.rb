require "rails_helper"

RSpec.describe "Movie Show" do
   describe "As a visitor" do
      describe "When I visit a movie's show page" do
         before :each do
            Studio.destroy_all
            Movie.destroy_all
            Actor.destroy_all
            ActorsMovies.destroy_all
            
            @studio1 = Studio.create!(name: "Lionsgate", location: "California")
            @studio2 = Studio.create!(name: "Lucasfilm", location: "USA")
            @studio3 = Studio.create!(name: "FOX", location: "New York")

            @johnwick = @studio1.movies.create!(title: "John Wick", creation_year: 2009, genre: "Adventure")
            @rambo = @studio1.movies.create!(title: "Rambo", creation_year: 1989, genre: "Action")
            @starwars = @studio2.movies.create!(title: "Star Wars", creation_year: 1977, genre: "Sci Fi")
            @indianajones = @studio2.movies.create!(title: "Indiana Jones", creation_year: 1982, genre: "Sci Fi Adventure")
            @familyguy = @studio3.movies.create!(title: "Family Guy The Movie", creation_year: 2011, genre: "Animated")
            @avatar = @studio3.movies.create!(title: "Avatar", creation_year: 2009, genre: "Who knows")
            @iceage = @studio3.movies.create!(title: "Ice Age", creation_year: 2002, genre: "Animated")

            @harrisonford = Actor.create!(name: "Harrison Ford", age: 75)
            @carriefisher = Actor.create!(name: "Carrie Fisher", age: 65)
            @sw = Actor.create!(name: "Sam Worthington", age: 35)
            @sigw = Actor.create!(name: "Sigourney Weaver", age: 77)
            @sm = Actor.create!(name: "Seth McFarlane", age: 42)
            @actor = Actor.create!(name: "Actor Face", age: 99)

            ActorsMovies.create!(actor: @harrisonford, movie: @starwars)
            ActorsMovies.create!(actor: @harrisonford, movie: @indianajones)
            ActorsMovies.create!(actor: @carriefisher, movie: @starwars)
            ActorsMovies.create!(actor: @sw, movie: @avatar)
            ActorsMovies.create!(actor: @sm, movie: @familyguy)
            ActorsMovies.create!(actor: @actor, movie: @iceage)
         end
         it "I see the movie's title, creation year, and genre" do
            visit "/movies/#{@johnwick.id}"
            expect(current_path).to eq("/movies/#{@johnwick.id}")
            expect(page).to have_content(@johnwick.title)
            within("#movie-#{@johnwick.id}") do
               expect(page).to have_content("Creation Year: #{@johnwick.creation_year}\nGenre: #{@johnwick.genre}")
            end
         end

         it "and a list of all actors from youngest to oldest" do
            visit "/movies/#{@johnwick.id}"

            within("#movie-#{@johnwick.id}-actors") do
               expect(page).to have_content("")
            end

            visit "/movies/#{@starwars.id}"
            within("#movie-#{@starwars.id}-actors") do
               expect(page).to have_content("Carrie Fisher\nHarrison Ford")
            end
            
         end

         it "and the average age of all the movie's actors" do
            visit "/movies/#{@starwars.id}"
            within("#movie-#{@starwars.id}-actors-average-age") do
               expect(page).to have_content("Average Age: 70")
            end

            visit "/movies/#{@johnwick.id}"

            within("#movie-#{@johnwick.id}-actors-average-age") do
               expect(page).to have_content("Average Age: 0")
            end
         end

         it "I do not see any actors listed that are not part of the movie" do
            visit "/movies/#{@starwars.id}"
            expect(page).to_not have_content("Sam Worthington")
            expect(page).to have_content("Carrie Fisher")
         end

         it "And I see a Form to add an actor to this movie" do
            visit "/movies/#{@starwars.id}"
            expect(page).to have_field(:search)
            expect(page).to have_button("Search for Actor")
                     
         end

         it "When I fill in the form with the name of an actor that exists in the database, and I click Submit, I am redirected back to that movie's show page" do
            visit "/movies/#{@starwars.id}" 
            fill_in :search, with: "Harrison Ford" 
            click_button "Search for Actor"
            expect(current_path).to eq("/movies/#{@starwars.id}")
         end

         it "I see the actor's name is now listed" do
            visit "/movies/#{@starwars.id}" 
            fill_in :search, with: "Seth McFarlane" 
            click_button "Search for Actor"

            expect(page).to have_content("Seth McFarlane")
         end
      end
   end
end