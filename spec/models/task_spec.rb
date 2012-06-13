# == Schema Information
#
# Table name: tasks
#
#  active     :boolean          default(TRUE), not null
#  created_at :datetime         not null
#  deleted_at :datetime
#  id         :integer          not null, primary key
#  status     :string(10)       not null
#  title      :string(100)      not null
#  updated_at :datetime         not null
#  user_id    :integer          not null
#

require 'spec_helper'

describe Task do
  before do
    (1..10).each do |i|
      task = Task.new(:title => "task #{i}")
      task.status = 'completed'   if i%2 == 0
      task.save!
    end
  end

  describe "validations" do
    it { should validate_presence_of(:title) }
    it { should_not allow_mass_assignment_of(:status) }
  end
  
  describe "list tasks" do
       
    it "should get pending tasks" do
      pending_tasks = Task.pending.pluck(:title)
      pending_tasks.should include("task 1")  
      pending_tasks.count.should eql 5
    end
    
    it "should get completed tasks" do
      completed_tasks = Task.completed.pluck(:title)
      completed_tasks.should include("task 2")  
      completed_tasks.count.should eql 5
    end
  end
  
  describe "add new task" do
    it "should assign a task as pending item upon creation" do
      task = Task.create!(:title => "Analysis")
      task.should be_pending  
    end
  end  
  
  describe "update a task" do
    it "should assign a task as pending item upon creation" do
      task = Task.create!(:title => "Analysis")
      task.update_attributes(:title => 'requirement Analysis')  
      task.title.should eql 'requirement Analysis'
    end
    
    it "should move pending task to completed task" do
      task = Task.first
      task.update_status('completed')
      task.should be_completed
    end
    
    it "should move completed task to pending task" do
      task = Task.completed.first
      task.update_status('pending')
      task.should be_pending
    end
    
  end  

  describe "remove task" do
    it "should remove a task" do
      Task.create!(:title => "Analysis")
      expect {
        Task.first.destroy
      }.to change(Task, :count).by(-1)
    end
  end
  
end
