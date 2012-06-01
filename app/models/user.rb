class User < ActiveRecord::Base
  has_secure_password
  attr_accessible :email, :mobile, :password, :password_confirmation
  
  validates :email,    :presence => true, :uniqueness => {:case_sensitive => false}
  validates :password, :presence => {:on => :create }, :confirmation => true
  validates :password_confirmation, :presence => true
  validates :mobile,   :presence => true
  
end
