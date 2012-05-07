class EventParticipation < ActiveRecord::Base
  belongs_to :event
  belongs_to :entry
  validates :event_id, :uniqueness => { :scope => :entry_id }
  
  best_performance_regex = /\A(\d*,{0}\.\d*m?|\d*:\d{2}\.\d*|\d*\.\d*)\z/
  
  validates_format_of :best_performance, :with => best_performance_regex, :allow_blank => true
  
  def best_performance=(val)
      if self.event.time_format
        self[:best_performance] = ChronicDuration.parse(val)   # parse the human input
      else
        self[:best_performance] = val
      end
    end
    
    comma do
      entry :name => 'Naam'
      event :name => 'Onderdeel'
      entry :licensenumber => 'Licentienummer'
      entry :birthdate => 'Geboortedatum'
      entry { |entry| entry.club.name }
      best_performance 'Beste prestatie'
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

