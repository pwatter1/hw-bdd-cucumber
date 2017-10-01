value = 0

Given /the following movies exist/ do |movies_table|
  value = 0
  movies_table.hashes.each do |movie|
    Movie.create(movie)
    value += 1
  end
end

Then /(.*) seed movies should exist/ do | n_seeds |
  Movie.count.should be n_seeds.to_i
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  page.body.match(/.*#{e1}.*#{e2}.*/)
end

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  rating_list.split(",").each do |rating|
    if uncheck
        uncheck "ratings_#{rating}"
    else
        check "ratings_#{rating}"
    end
  end
end

Then /I should see all the movies/ do
  page.should have_css("table#movies tbody tr",:count => value.to_i)
end
