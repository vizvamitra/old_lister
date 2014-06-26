Feature: manage list items on the mein page

  As a guest
  So that I can try application without any registration
  I want to have an ability to add, edit and remove list items

Background: user is currently on a home page
  
  Given I am on the Lister home page

@javascript
Scenario: adding a new list item
  When I fill in "list_item_text" with "buy eggs"
  And I press "enter" key
  Then the "textarea" field should be empty
  And I should see "buy eggs"