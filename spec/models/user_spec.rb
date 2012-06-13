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
#  updated_at             :datetime         not null
#

require 'spec_helper'

describe User do
  pending "add some examples to (or delete) #{__FILE__}"
end
