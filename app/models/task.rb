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

#Globalize::ActiveRecord::Translation.class_eval do
#  attr_accessible :locale
#end

class Task < ActiveRecord::Base

 
  COMPLETED = 'completed'
  PENDING   = 'pending'

  attr_accessible :title


  validates :title, :presence => true
  before_create :set_default_status

  def update_status(new_status)
    return false  unless [COMPLETED, PENDING].include?(new_status)
    self.status = new_status
    self.save!
  end
  
  def pending?
    status == PENDING
  end
  
  def completed?
    status == COMPLETED
  end

  private 
  def set_default_status
    self.status = PENDING unless status
  end

end
