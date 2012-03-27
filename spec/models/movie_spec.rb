require 'spec_helper'

describe Movie do
  describe 'when searching for associated director to a given movie' do
    it 'should look for the movie' do
      # ARRANGE
      given_id = '1'
      movie = mock(Movie)
      movie.stub(:director).and_return('Blah')

      # ASSERT
      Movie.should_receive(:find).with(given_id).and_return(movie)

      # ACT
      Movie.find_director(given_id)
    end

    it 'should return the associated director' do
      # ARRANGE
      movie = mock(Movie)
      movie.stub(:director).and_return('George Lucas')
      Movie.stub(:find).with('4').and_return(movie)

      # ACT & ASSERT
      Movie.find_director('4').should == 'George Lucas'
    end
  end

  describe 'when searching for all similar movies' do
    it 'should look for the associated director to the given movie id' do
      # ARRANGE
      given_id = '3'
      
      # ASSERT
      Movie.should_receive(:find_director).with(given_id)

      # ACT
      Movie.find_similar_movies(given_id)
    end

    it 'should look for the matching records with the given director' do
      # ARRANGE
      given_id = '3'
      Movie.stub(:find_director).and_return('George Lucas')

      # ACT
      #Movie.find_similar_movies(given_id)

      # ASSERT
      Movie.should_receive(:where).with(director: 'George Lucas')

      # ACT
      Movie.find_similar_movies(given_id)
    end
  end

  describe 'when checking if the movie has an associated director' do
    it 'should leverage find_director behaviour' do
      # ARRANGE
      given_id = '4'

      # ASSERT
      Movie.should_receive(:find_director).with(given_id)

      #ACT
      Movie.has_no_director?(given_id)
    end

    context 'and there is no associated director' do
      it 'should confirm there is no associated director' do
        # ARRANGE
        id_for_movie_with_no_director = '1'
        Movie.stub(:find_director).and_return(nil)

        # ACT & ASSERT
        Movie.has_no_director?(id_for_movie_with_no_director).should be_true
      end
    end

    context 'and there is an associated director' do
      it 'should confirm there is an associatoed director' do
        # ARRANGE
        id_for_movie_with_director = '2'
        Movie.stub(:find_director).and_return('George Lucas')

        # ACT & ASSERT
        Movie.has_no_director?(id_for_movie_with_director).should be_false
      end
    end
  end
end
