class EventParticipation < ActiveRecord::Base
  belongs_to :event
  belongs_to :entry
  validates :event_id, :uniqueness => { :scope => :entry_id }
  
  def best_performance=(val)
      if self.event.time_format
        self[:best_performance] = ChronicDuration.parse(val)   # parse the human input
      else
        self[:best_performance] = val
      end
    end
end
# == Schema Information
#
# Table name: event_participations
#
#  id               :integer         not null, primary key
#  event_id         :integer
#  entry_id         :integer
#  best_performance :float
#  best_date        :date
#  best_location    :string(255)
#  created_at       :datetime        not null
#  updated_at       :datetime        not null
#

