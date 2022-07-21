class Actor < ApplicationRecord
   has_many :actors_movies, :class_name => "ActorsMovies"
   has_many :movies, through: :actors_movies

   validates_presence_of :name, :age
   
end