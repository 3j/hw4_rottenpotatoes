require 'spec_helper'

describe MoviesController do
  describe 'when finding movies with same director' do
    it 'should call the model method that performs actual search with director' do
      # ASSERT
      Movie.should_receive(:find_with_current_director).with('George Lucas')

      # ACT
      post :similar_movies_to, {search_terms: 'George Lucas'}
    end

    it 'should select the Find More From Director template' do
      # ACT
      post :similar_movies_to

      # ASSERT
      response.should render_template(:similar_movies_to)
    end

    it 'should make the results from model available to the template' do
      # ARRANGE
      fake_results = [mock(Movie), mock(Movie)]
      Movie.stub(:find_with_current_director).and_return(fake_results)

      # ACT
      post :similar_movies_to

      # ASSERT
      assigns(:movies).should == fake_results
    end
  end
end
