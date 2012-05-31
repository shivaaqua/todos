Feature: Todo management
In order to manage my daily tasks
As a normal user
I need a simple task management interface

  Scenario: Very first visit
    Given I am on todo page as a normal user
    When I visit the todos application for very first time
    Then I should not see any pending tasks
    And I should not see any completed tasks

  Scenario: Add new tasks
    Given I am on todo page as a normal user
    And I have no pending tasks
    When I add following tasks 
      | title                |
      | Analysis             |
      | Design               |
      | Development          |
      | Testing              |
    Then I should see the following tasks under "Pending tasks" category
      | title                |
      | Analysis             |
      | Design               |
      | Development          |
      | Testing              |

  Scenario: Update a task
      Given I am on todo page as a normal user
      And I have following "pending" tasks
        | title                |
        | Analysis             |
        | Design               |
        | Development          |
        | Testing              |
      When I update task title "Analysis" to "Requirement Analysis"
      Then I should see "Task was successfully updated." message
      And I should see the following tasks under "Pending tasks" category
        | title                |    
        | Requirement Analysis |
        | Design               |
        | Development          |
        | Testing              |
        
  Scenario: Mark a task as completed
      Given I am on todo page as a normal user
      And I have following "pending" tasks
        | title                |    
        | Analysis             |
        | Design               |
        | Development          |
        | Testing              |
      When I click on "Mark as completed" icon for "Analysis" task
      Then I should see the following tasks under "Pending tasks" category
        | title                |    
        | Design               |
        | Development          |
        | Testing              |
      And I should see the following tasks under "Completed tasks" category
        | title                |    
        | Analysis             |


  Scenario: Mark a task as pending
    Given I am on todo page as a normal user
    And I have following "pending" tasks
      | title                |
      | Development          |
      | Testing              |
    And I have following "completed" tasks
      | title                |
      | Analysis             |
      | Design               |      
    When I click on "Mark as pending" icon for "Analysis" task
    Then I should see the following tasks under "Pending tasks" category
      | title                |
      | Analysis             |
      | Development          |
      | Testing              |
    And I should see the following tasks under "Completed tasks" category
      | title                |    
      | Design               |
      
      
      
  Scenario: Delete a task
    Given I am on todo page as a normal user
    And I have following "pending" tasks
      | title                |    
      | Analysis             |
      | Design               |
      | Development          |
      | Testing              |
    When I click on "Delete" icon for "Analysis" task
    Then I should see "Task removed successfully" message
    And I should see the following tasks under "Pending tasks" category
      | title                |
      | Design               |
      | Development          |
      | Testing              |


