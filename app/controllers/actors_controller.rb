class ActorsController < ApplicationController

   def search
      @actor = Actor.search(params[:search])
      if @actor
         @movie = Movie.find(params[:movie_id])
         @movie.actors << @actor
         @movie.save
      end
      redirect_to "/movies/#{params[:movie_id]}"
   end
end