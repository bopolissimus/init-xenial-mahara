@javascript @core @core_administration @allow_popups
 Feature:Injecting sql in groups search field
    In order to inject javascript in group search field and group name field
    As an admin
    To see if mahara is secure enough

Background:
    Given the following site settings are set:
    | field | value |
    | skins | 1 |


# check to see if "I should not see a popup" step definition fails when there is a page that has a popup
Scenario: I should see a popup
    Given I log in as "admin" with password "Kupuh1pa!"
    And I choose "Résumé" in "Create" from main menu
    And I follow "Education and employment"
    # Adding Education history
    And I press "Add education history"
    And I set the following fields to these values:
    | addeducationhistory_startdate | 1 Jan 2009 |
    | addeducationhistory_enddate | 2 Dec 2010 |
    | addeducationhistory_institution | University of Life |
    | addeducationhistory_institutionaddress | 2/103 Industrial Lane |
    | addeducationhistory_qualtype | Masters of Arts |
    | addeducationhistory_qualname | North American Cultural Studies |
    | addeducationhistory_qualdescription | This qualification is a 4.5-year degree that ends in writing a Master's thesis. |
    And I scroll to the base of id "educationhistoryform"
    And I attach the file "Image2.png" to "Attach file"
    When I press "Save"
    And I follow "Delete"
    And I should see "Are you sure you want to delete this?" in popup
    And I accept the confirm popup
