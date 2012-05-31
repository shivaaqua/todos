require Rails.root.to_s +  '/lib/sahi'

Task.destroy_all

browser = Sahi::Browser.new("chrome")
browser.open
home_page = "http://localhost:3000"
tasks = []

at_exit do
  browser.close
end

Given /^I am on todo page as a normal user$/ do
  browser.navigate_to(home_page)
end

When /^I visit the todos application for very first time$/ do
  browser.navigate_to(home_page)
end

Then /^I should not see any pending tasks$/ do
  browser.fetch("$('#pending_tasks_table tr').length").should eql "0"
end

Then /^I should not see any completed tasks$/ do
  browser.fetch("$('#completed_tasks_table tr').length").should eql "0"
end

And /^I have no pending tasks$/ do
  Task.destroy_all(:status => 'pending')
end

When /^I add following tasks$/ do |table|
  table.hashes.each do |hash|
    browser.textbox("task[title]").value = hash[:title]
    browser.submit("Go").click
  end
end

Then /^I should see the following tasks under "(.*?)" category$/ do |category, table|
  puts category.inspect
  table.hashes.each do |hash|
    browser.fetch("$(\"td:contains('#{hash[:title]}') > h2\").text()").should eql category
  end
end

Given /^I have following "(.*?)" tasks$/ do |status, table|
  table.hashes.each do |hash|
    task = Task.new(:title => hash[:title])
    task.status = status
    task.save!  
  end
  browser.navigate_to(home_page) 
end

When /^I update task title "(.*?)" to "(.*?)"$/ do |old_title, new_title|
  browser.image("Edit[3]").click
  browser.textbox("task[title]").value = new_title
  browser.submit("Go").click
end

When /^I click on "(.*?)" icon for "(.*?)" task$/ do |icon, task|
  if icon =='delete'
    status ='pending' #only pending task can be deleted so it is assumed like this
  else  
    # we are clicking mark as pending for completed task and vice versa
    status = (icon.gsub("Mark as ","") == 'pending') ? 'completed' : 'pending' 
  end  
  tasks = Task.where(:status => status).collect{|x| x.title}
  index = tasks.index(task)
  browser.image("#{icon}[#{index}]").click
end

Then /^I should see "(.*?)" message$/ do |message|
  browser.fetch("$('.notice').text()").should eql message
end


=begin

When /^I add new task$/ do
  browser.textbox("task[title]").value = "My favorite task"
  browser.submit("Go").click
end

Then /^I should see the task under "(.*?)" category$/ do |category|
  category = category.gsub!(" tasks", '')
  if category == 'pending'
    browser.fetch("$('td:contains(\'My favorite task\') > h2').text()").should eql "Pending tasks"
  end
end

And /^I should have "(.*?)" pending task$/ do |count|
  browser.fetch("$('#pending_tasks_table tr').length").should eql count
end

When /^I add multiple tasks$/ do
  (1..10).each do |i|
    browser.textbox("task[title]").value = "My favorite task #{i}"
    browser.submit("Go").click
  end
end

Then /^I should see all the tasks under "(.*?)" category$/ do |category|
  category = category.gsub!(" tasks", '')
  (1..10).each do |i|
    browser.fetch("$('td:contains(\"My favorite task #{i}\") > h2').text()").should eql "Pending tasks"
  end
end

When /^I edit a todo item under "Pending tasks" category$/ do
  browser.image("Edit").click
end

When /^I update the task title$/ do
  browser.textbox("task[title]").value = "My new favorite task"
  browser.submit("Go").click
end


Then /^I should see the updated task title in "Pending tasks" category$/ do
  browser.fetch("$('td:contains(\"My new favorite task\") > h2').text()").should eql "Pending tasks"
end

When /^I click on "(.*?)" icon for a todo item under "(.*?)" list$/ do |icon, category|
  browser.image("Mark as completed").click
end

Then /^I should see the task moved to "(.*?)" category$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end


-----------------




Given /^I have no task pending or completed$/ do
  Task.destroy_all
end


end

Then /^I should see the task under "(.*?)" category$/ do |category|
  category = category.gsub!(" tasks", '')
  Task.find_by_title("My favorite task").status.should eql 'pending'
end

When /^I edit a todo item under any category$/ do
  browser.image("Edit").click
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
  browser.cell("My updated task").text.should eql 'My updated task' 
  Task.find_by_title("My updated task").status.should eql @task.status 
end


When /^I select a todo item under "Pending tasks" list$/ do 
end

When /^I click on "mark as completed" icon$/ do 
  browser.image("mark_as_completed").near(browser.cell("My updated task")).click   
end

Then /^I should see the task moved to "Completed tasks" category$/ do
  Task.find_by_title("My updated task").status.should eql 'completed'
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

=end
