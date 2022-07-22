require 'rails_helper'

RSpec.describe Movie do
  describe "validations" do
    it {should validate_presence_of :title }
    it {should validate_presence_of :creation_year }
    it {should validate_presence_of :genre }
  end
  describe 'relationships' do
    it { should belong_to :studio }
    it { should have_many(:actors).through :actors_movies }
  end

  describe "instance methods" do
    before :each do
      @harrisonford = Actor.create!(name: "Harrison Ford", age: 75)
      @carriefisher = Actor.create!(name: "Carrie Fisher", age: 65)
      @studio2 = Studio.create!(name: "Lucasfilm", location: "USA")
      @starwars = @studio2.movies.create!(title: "Star Wars", creation_year: 1977, genre: "Sci Fi")
      ActorsMovies.create!(actor: @harrisonford, movie: @starwars)
      ActorsMovies.create!(actor: @carriefisher, movie: @starwars)
    end

    it "#actors_sorted_by_age" do
      expect(@starwars.actors_sorted_by_age).to match_array([@carriefisher, @harrisonford])
    end

    it "#actors_average_age" do
      expect(@starwars.actors_average_age).to eq(70)
    end
  end
end