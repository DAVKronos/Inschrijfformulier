class EventParticipation < ActiveRecord::Base
  belongs_to :event
  belongs_to :registration
  validates :event_id, :uniqueness => { :scope => :registration_id }
end
# == Schema Information
#
# Table name: event_participations
#
#  id               :integer         not null, primary key
#  event_id         :integer
#  registration_id  :integer
#  best_performance :string(255)
#  best_date        :date
#  best_location    :string(255)
#  created_at       :datetime        not null
#  updated_at       :datetime        not null
#

