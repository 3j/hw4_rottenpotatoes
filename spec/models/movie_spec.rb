require 'spec_helper'

describe Movie do
  describe 'when searching all the movies from a given director' do
    it 'should look for the matching records' do
      # ASSERT
      Movie.should_receive(:where).with(director: 'George Lucas')

      # ACT
      Movie.find_similar_movies('George Lucas')
    end
  end
end
