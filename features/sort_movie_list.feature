Feature: display list of movies sorted by different criteria
 
  As an avid moviegoer
  So that I can quickly browse movies based on my preferences
  I want to see movies sorted by title or release date

Background: movies have been added to database
  
  Given the following movies exist:
  | title                   | rating | director | release_date |
  | Aladdin                 | G      |          | 25-Nov-1992  |
  | The Terminator          | R      |          | 26-Oct-1984  |
  | When Harry Met Sally    | R      |          | 21-Jul-1989  |
  | The Help                | PG-13  |          | 10-Aug-2011  |
  | Chocolat                | PG-13  |          | 5-Jan-2001   |
  | Amelie                  | R      |          | 25-Apr-2001  |
  | 2001: A Space Odyssey   | G      |          | 6-Apr-1968   |
  | The Incredibles         | PG     |          | 5-Nov-2004   |
  | Raiders of the Lost Ark | PG     |          | 12-Jun-1981  |
  | Chicken Run             | G      |          | 21-Jun-2000  |

  And I am on the RottenPotatoes home page

  And I check the following ratings: G, PG, PG-13, R
  And I press the "Submit" button

Scenario: sort movies alphabetically
  When I click on "Movie Title"
  Then I should see "Amelie" before "Chocolat"
  And I should see "2001: A Space Odyssey" before "The Terminator"
  And I should see "Aladdin" before "Amelie"
  #And I should see "Chicken Run" before "Aladdin"

Scenario: sort movies in increasing order of release date
  When I click on "Release Date"
  Then I should see "2001: A Space Odyssey" before "Chicken Run"
  And I should see "Raiders of the Lost Ark" before "Amelie"
  #And I should see "The Help" before "When Harry Met Sally"