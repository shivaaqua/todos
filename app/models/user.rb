# == Schema Information
#
# Table name: users
#
#  created_at             :datetime         not null
#  email                  :string(150)      not null
#  id                     :integer          not null, primary key
#  mobile                 :string(15)       not null
#  password_digest        :string(255)      not null
#  password_reset_sent_at :datetime
#  password_reset_token   :string(255)
#  updated_at             :datetime         not nulll
#

class User < ActiveRecord::Base
  require "task_scope"
 
  has_secure_password
  
  has_many :authorizations
  has_many :tasks, :extend => TaskScope 
  
  attr_accessible :email, :mobile, :password, :password_confirmation
  
  validates :email,    :presence => true, :uniqueness => {:case_sensitive => false}
  validates :password, :presence => {:on => :create }, :confirmation => true
  validates :password_confirmation, :presence => {:if => :password_present?} 
  validates :mobile,   :presence => true, :length => {:maximum => 15 }
  
  def self.authenticate(login, password)
    find_by_email(login).try(:authenticate, password)
  end
  
  def associate_account(auth_id=nil) 
    authorize = Authorization.find(auth_id)
    authorize.update_attributes(:user_id => self.id)  if auth_id
  end
  
  def send_new_password
    begin
      self.password_reset_token   = SecureRandom.urlsafe_base64
      self.password_reset_sent_at = Time.zone.now
      save!
      c = UserMailer.password_reset(self).deliver
    rescue => e
      false
    end  
  end
  
  def password_reset_expired?
    password_reset_sent_at < 2.hours.ago
  end
  
  private
  def password_present?
    password.present?
  end
end
