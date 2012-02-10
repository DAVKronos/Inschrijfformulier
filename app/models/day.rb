class Day < ActiveRecord::Base
  has_many :volunteer_days
  has_many :registrations, :through => :volunteer_days 
end
# == Schema Information
#
# Table name: days
#
#  id         :integer         not null, primary key
#  date       :date
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

