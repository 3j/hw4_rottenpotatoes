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

