# == Schema Information
#
# Table name: authorizations
#
#  created_at :datetime         not null
#  email      :string(255)
#  id         :integer          not null, primary key
#  provider   :string(255)      not null
#  uid        :string(255)      not null
#  updated_at :datetime         not null
#  user_id    :integer
#

class Authorization < ActiveRecord::Base
  belongs_to :user
  
  attr_accessible :email, :provider, :uid, :user_id

  def self.find_from_hash(hash, user=nil)
    find_by_provider_and_uid(hash[:provider], hash[:uid])
  end  
  
  def self.find_or_create_from_hash(hash, user=nil)
    record       = find_or_initialize_by_provider_and_uid(hash[:provider], hash[:uid].to_s)
    record.email = hash[:info]['email']
    record.save unless record.persisted?
    record
  end
  
  def associate_user(user_id)
    update_attributes({:user_id => user_id})
  end
  
  
end
