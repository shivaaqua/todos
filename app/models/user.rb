class User < ActiveRecord::Base
  has_secure_password
  has_many :authorizations
  
  attr_accessible :email, :mobile, :password, :password_confirmation
  
  validates :email,    :presence => true, :uniqueness => {:case_sensitive => false}
  validates :password, :presence => {:on => :create }, :confirmation => true
  validates :password_confirmation, :presence => true
  validates :mobile,   :presence => true, :length => {:maximum => 15 }
  
  def self.authenticate(login, password)
    find_by_email(login).try(:authenticate, password)
  end
  
  def associate_account(auth_id=nil) 
    authorize = Authorization.find(auth_id)
    authorize.update_attributes(:user_id => self.id)  if auth_id
  end
  
end
