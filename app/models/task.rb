class Task < ActiveRecord::Base
  COMPLETED = 'completed'
  PENDING   = 'pending'

  attr_accessible :title

  validates :title, :presence => true

  before_create :set_default_status

  scope :pending, where("status = ?", PENDING)
  scope :completed, where("status = ?", COMPLETED)

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
