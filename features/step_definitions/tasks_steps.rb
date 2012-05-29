require Rails.root.to_s +  '/lib/sahi'

browser = Sahi::Browser.new("chrome")
browser.open

at_exit do
  browser.close
end

Given /^I am a normal user$/ do
  #Nothing to do for guest
end

When /^I visit the todos application for very first time$/ do
  browser.navigate_to("http://localhost:3000")
end

Then /^I should not see any pending tasks$/ do
  raise 'error' if browser.cell("Pending").exists?  
end

Then /^I should not see any completed tasks$/ do
  raise 'error' if browser.cell("Completed").exists?
end

Given /^I have no task pending or completed$/ do
  Task.destroy_all
end

Given /^I am on todo page as a normal user$/ do
  browser.navigate_to("http://localhost:3000")
end

When /^I add new task$/ do
  browser.textbox("task[title]").value = "My favorite task"
  browser.submit("Go").click
end

Then /^I should see the task under "(.*?)" category$/ do |category|
  category = category.gsub!(" tasks", '')
  browser.cell(category).exists?.should be_true
end

When /^I edit a todo item under any category$/ do
  browser.link("Edit").click
  task = browser.textbox("task[title]").value
  @task = Task.find_by_title(task)
end

Then /^I should be able to update only its title$/ do
  browser.textbox("task[title]").value.should eql 'My favorite task'
end

Given /^I have a pending task$/ do
end

When /^I update the task title$/ do
  browser.textbox("task[title]").value = 'My updated task'
  browser.submit("Go").click
end

Then /^I should see task with updated title under "(.*?)" category$/ do |arg1|
  browser.cell("My updated task").text.should eql 'My updated task' 
  task = browser.textbox("task[title]").value
  Task.find_by_title(task).status.should eql @task.status 
end

Then /^I should see task with updated title under respective category$/ do
  Task.find_by_title('My updated task').status.should eql 'pending'
end


When /^I select a todo item under "(.*?)" list$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

When /^I click on "(.*?)" icon$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

Then /^I should see the task moved under "(.*?)" category$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

When /^I select a todo item$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^I should see "(.*?)" message$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

Then /^the task should not be in the task list$/ do
  pending # express the regexp above with the code you wish you had
end
