class Movie < ActiveRecord::Base
  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end

  def self.find_similar_movies(movie_id)
    director = Movie.find_director(movie_id)
    Movie.where(director: director)
  end

  def self.find_director(movie_id)
    Movie.find(movie_id).director
  end

  def self.has_no_director?(movie_id)
    Movie.find_director(movie_id).blank?
  end
end
