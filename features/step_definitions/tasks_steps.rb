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


