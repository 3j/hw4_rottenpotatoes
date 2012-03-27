require 'spec_helper'

describe MoviesController do
  describe 'when finding similar movies with same director' do
    context 'and there is a director' do
      it 'should call the model method that performs actual search with movie id' do
        # ARRANGE
        movie_id = '22'
        Movie.stub(:has_no_director?).and_return(false)
        
        # ASSERT
        Movie.should_receive(:find_similar_movies).with(movie_id)

        # ACT
        post :similar_movies, {id: '22'}
      end

      it 'should select the Similar Movies template' do
        # ARRANGE
        Movie.stub(:has_no_director?).and_return(false)
        Movie.stub(:find_similar_movies).and_return(mock(Movie))

        # ACT
        post :similar_movies, {id: '1'}

        # ASSERT
        response.should render_template(:similar_movies)
      end

      it 'should make the results from model available to the template' do
        # ARRANGE
        Movie.stub(:has_no_director?).and_return(false)
        fake_results = [mock(Movie), mock(Movie)]
        Movie.stub(:find_similar_movies).and_return(fake_results)

        # ACT
        post :similar_movies, {id: '1'}

        # ASSERT
        assigns(:movies).should == fake_results
      end
    end

    context 'and there is no director' do
      it 'should check if movie has a director' do
        # ARRANGE
        Movie.stub(:find_director).and_return(nil)

        # ASSERT
        Movie.should_receive(:has_no_director?).and_return(true)

        # ACT
        post :similar_movies, {id: '1'}
      end

      it 'should redirect to the movies home page with nil director' do
        # ARRANGE
        Movie.stub(:has_no_director?).and_return(true)
        Movie.stub(:find_director).and_return(nil)

        # ACT
        post :similar_movies, {id: '1'}

        # ASSERT
        response.should redirect_to(movies_path)
      end

      it 'should redirect to the movies home page with empty director' do
        # ARRANGE
        Movie.stub(:find_director).and_return('')

        # ACT
        post :similar_movies, {id: '1'}

        # ASSERT
        response.should redirect_to(movies_path)
      end

      it 'should warn us that the current movie has no director' do
        # ARRANGE
        alien = mock(Movie)
        alien.stub(:title).and_return('Alien')
        Movie.stub(:find_director).and_return('')

        # ACT
        post :similar_movies, {id: '1'}

        # ASSERT
        flash[:notice].should == "'#{alien.title}' has no director info"
      end
    end
  end
end
