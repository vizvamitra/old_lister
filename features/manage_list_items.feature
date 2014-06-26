@javascript
Feature: manage list items on the mein page

  As a guest
  So that I can try application without any registration
  I want to have an ability to add, edit and remove list items

Background: user is currently on a home page
  
  Given list item "buy milk" exists
  And I am on the Lister home page

Scenario: adding a new list item
  When I fill in "list_item_text" with "buy eggs"
  And I press "add"
  Then the "textarea" field should be empty
  And I should see "buy eggs"

Scenario: editing list item
  When I add " and corn flakes" to "buy milk" list item
  And reload the page
  Then I should see "buy milk and corn flakes"

Scenario: marking list item done
  When I press "done" button of "buy milk" list item
  Then "buy milk" list item should be marked done

Scenario: marking list item not done
  Given "buy milk" list item is done
  When I press "done" button of "buy milk" list item
  Then "buy milk" list item should not be marked done

Scenario: deleting list item
  When I press "delete" button of "buy milk" list item
  Then I should not see "buy milk"