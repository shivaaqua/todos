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

require 'spec_helper'

describe Authorization do
  pending "add some examples to (or delete) #{__FILE__}"
end
