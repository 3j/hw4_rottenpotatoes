require 'spec_helper'

describe Movie do
  describe 'when searching all the movies from a given director' do
    #it "should return a movie collection with the matches" do
    #  # ARRANGE
    #  fake_movie_collection = 
    #  # ACT
    #  movie_collection = Movie.find_with_current_director('George Lucas')

    #  # ASSERT
    #  movie_collection.should == fake_movie_collection
    #end
    #it 'should return a collection of movies' do
    #  Movie.find_with_current_director('blah')
    #end
    it 'should return only the movies from the desired director' do
      # ASSERT
      Movie.should_receive(:where).with(director: 'George Lucas')

      # ACT
      Movie.find_with_current_director('George Lucas')
    end
    
  end
end
