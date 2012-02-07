class EventParticipation < ActiveRecord::Base
  belongs_to :event
  belongs_to :registration
end
# == Schema Information
#
# Table name: event_participations
#
#  id              :integer         not null, primary key
#  event_id        :integer
#  registration_id :integer
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#

