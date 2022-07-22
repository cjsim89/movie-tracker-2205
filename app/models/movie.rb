class Movie < ApplicationRecord
  belongs_to :studio
  has_many :actors_movies, :class_name => "ActorsMovies"
  has_many :actors, through: :actors_movies
  validates_presence_of :title, :creation_year, :genre
  
  def actors_sorted_by_age
    actors.order(:age)
  end

  def actors_average_age
    actors.average(:age).to_i || 0
  end
end