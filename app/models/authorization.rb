class Authorization < ActiveRecord::Base
  belongs_to :user
  
  attr_accessible :email, :provider, :uid, :user_id

  def self.find_from_hash(hash, user=nil)
    find_by_provider_and_uid(hash[:provider], hash[:uid])
  end  
  
  def self.create_from_hash(hash, user=nil)
    record       = find_or_initialize_by_provider_and_uid(hash[:provider], hash[:uid])
    record.email = hash[:info]['email']
    record.save unless record.persisted?
    record
  end
end
