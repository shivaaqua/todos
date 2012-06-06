module Authorize
  def create_from_hash(hash)
    if hash
      record = find_or_create_by_provider_and_uid(hash[:provider], hash[:uid])
      record.update_attributes({:email => hash[:info]['email']})
    end  
  end
end
