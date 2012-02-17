class Authentication < ActiveRecord::Base
  belongs_to :participant
end
# == Schema Information
#
# Table name: authentications
#
#  id             :integer         not null, primary key
#  participant_id :integer
#  provider       :string(255)
#  uid            :string(255)
#  created_at     :datetime        not null
#  updated_at     :datetime        not null
#

