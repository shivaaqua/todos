module TaskScope 
  COMPLETED = 'completed'
  PENDING   = 'pending'
  
  def pending
    where("status = ?", PENDING)
  end
  def completed  
    where("status = ?", COMPLETED)
  end
end
