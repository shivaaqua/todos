Feature: Todo management
In order to manage my daily tasks
As a normal user
I need a simple task management interface

Scenario: Very first visit
Given I am a normal user
When I visit the todos application for very first time
Then I should not see any pending tasks
And I should not see any completed tasks

Scenario: Add new todo
Given I am on todo page as a normal user
And I have no task pending or completed
When I add new task 
Then I should see the task under "Pending tasks" category

Scenario: Only title of a task is editable
Given I am on todo page as a normal user
When I edit a todo item under any category
Then I should be able to update only its title

Scenario: Update a todo
Given I am on todo page as a normal user
When I edit a todo item under any category
And  I update the task title
Then I should see task with updated title under respective category

Scenario: Mark a task as completed
Given I am on todo page as a normal user
When I select a todo item under "Pending Tasks" list
And I click on "mark as completed " icon 
Then I should see the task moved under "Completed tasks" category

Scenario: Mark a task as pending
Given I am on todo page as a normal user
When I select a todo item under "Completed Tasks" list
And I click on "mark as pending" icon 
Then I should see the task moved under "Pending tasks" category

Scenario: Delete a task
Given I am on todo page as a normal user
When I select a todo item
And I click on "delete" icon 
Then I should see "Task removed successfully" message
And the task should not be in the task list


