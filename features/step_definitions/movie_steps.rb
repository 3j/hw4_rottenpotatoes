Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create!(title: movie[:title],
                  rating: movie[:rating],
                  director: movie[:director],
                  release_date: movie[:release_date])
  end
end

Then /^the director of "([^"]*)" should be "([^"]*)"$/ do |title, director|
  director.should match(Movie.find_by_title(title).director)
end

Then /^I debug$/ do
  debugger
end

# Using the default 'should see' from web_steps.rb
# This one is more accurate (similar to the one I wrote for HW3)
# Just in case

#Then /^(?:|I )should see "([^"]*)"$/ do |text|
#  path_to_title_column = '//table/tbody/tr/td[1]'
#  regexp = Regexp.new("^#{text}$")
#
#  if page.respond_to? :should
#    page.should have_xpath(path_to_title_column, :text => regexp)
#  else
#    assert page.has_xpath?(path_to_title_column, :text => regexp)
#  end
#end

# FROM HW3

When /^(?:|I )check "([^"]*)" rating$/ do |field|
  ratings_field = "ratings_#{field}"
  check(ratings_field)
end

When /^(?:|I )uncheck "([^"]*)" rating$/ do |field|
  ratings_field = "ratings_#{field}"
  uncheck(ratings_field)
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /^I check the following ratings: (.*)$/ do |rating_list|
  rating_list.split(%r{,\s*}).each do |rating|
    step %{I check "#{rating}" rating}
  end
end

When /^I uncheck the following ratings: (.*)$/ do |rating_list|
  rating_list.split(%r{,\s*}).each do |rating|
    step %{I uncheck "#{rating}" rating}
  end
end

When /^(?:|I )press the "([^"]*)" button$/ do |button|
  ratings_button = "ratings_#{button.downcase}"
  click_button(ratings_button)
end

Then /^(?:|I )should see "([^"]*)" movies$/ do |text|
  path_to_ratings_column = '//table/tbody/tr/td[2]'
  # Needed in order to avoid false positives like
  # 'G' in 'PG-13' (G is contained in PG-13)
  # 'PG' in 'PG-13' (PG is contained in PG-13)
  regexp = Regexp.new("^#{text}$")

  if page.respond_to? :should
    page.should have_xpath(path_to_ratings_column, :text => regexp)
  else
    assert page.has_xpath?(path_to_ratings_column, :text => regexp)
  end
end

Then /^(?:|I )should not see "([^"]*)" movies$/ do |text|
  path_to_ratings_column = '//table/tbody/tr/td[2]'
  # Needed in order to avoid false positives like
  # 'G' in 'PG-13' (G is contained in PG-13)
  # 'PG' in 'PG-13' (PG is contained in PG-13)
  regexp = Regexp.new("^#{text}$")

  if page.respond_to? :should
    page.should have_no_xpath(path_to_ratings_column, :text => regexp)
  else
    assert page.has_no_xpath?(path_to_ratings_column, :text => regexp)
  end
end

Then /^I should see all of the movies$/ do
  movies_count = Movie.count
  if page.respond_to? :should
    page.should have_css("table#movies tbody tr", :count => movies_count)
  else
    assert page.has_css?("table#movies tbody tr", :count => movies_count)
  end
end

When /^(?:|I )click on "Movie Title"$/ do 
  movie_title_link = "title_header"
  click_link(movie_title_link)
end

When /^(?:|I )click on "Release Date"$/ do 
  release_date_link = "release_date_header"
  click_link(release_date_link)
end

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.content  is the entire content of the page as a string.
  #e1_appears_before_e2_regexp = Regexp.new(".*#{e1}.*#{e2}.*"/m)
  #puts page.body
  if page.respond_to? :should
    page.body.should =~ /.*#{e1}.*#{e2}.*/m
  else
    assert page.body =~ /.*#{e1}.*#{e2}.*/m
  end
end
