class Task < ActiveRecord::Base
  ACTIVE  = 'active'
  PENDING = 'pending'

  attr_accessible :title

  validates :title, :presence => true

  before_save :set_default_status

  scope :pending, where("status = ?", PENDING)
  scope :completed, where("status = ?", ACTIVE)

  
  private 
  def set_default_status
    self.status = PENDING
  end

end
