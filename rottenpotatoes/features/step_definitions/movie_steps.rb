# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create!(movie)
  end
end

Then /(.*) seed movies should exist/ do | n_seeds |
  Movie.count.should be n_seeds.to_i
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  page.body.index(e1) < page.body.index(e2)
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
    @ratings_array = rating_list.split(' ')
  if uncheck
    @ratings_array.each { |rating| 
    steps %Q{When I uncheck "#{rating}"}
    }
  else
    @ratings_array.each { |rating| 
      steps %Q{When I check "#{rating}"}
    }
  end
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
end

Then /I should see all of the movies/ do
  steps %Q{
    Then I should see "Aladdin"
    And I should see "2001: A Space Odyssey"
    And I should see "Amelie"
    And I should see "Chicken Run"
    And I should see "Chocolat"
    And I should see "The Terminator"
    And I should see "The Help"
    And I should see "The Incredibles"
    And I should see "Raiders of the Lost Ark"
    And I should see "When Harry Met Sally"
  }
end
