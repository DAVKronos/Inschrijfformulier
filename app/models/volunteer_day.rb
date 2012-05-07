class VolunteerDay < ActiveRecord::Base
  belongs_to :day
  belongs_to :entry
  
  comma do
    day :date => 'Dag'
    entry :name => 'Naam'
    entry :onderdeel_voorkeuren => 'Voorkeuren'
    entry :jureren => 'Jureren'
    entry :materiaalploeg => 'MateriaalPloeg'
    entry :catering => 'Catering'
    entry :jury_algemeen => 'Jury Algemeen'
    entry :jury_tijd => 'Jury Tijd'
    entry :jury_scheidsrechter => 'Jury Scheidsrechter'
    entry :meldbureau => 'Meldbureau'
    entry :wedstrijdsec => 'Wedstrijdsecretariaat'
    entry :tshirtmaat => 'Maat vrijwilligersshirt'
    
  end
end
# == Schema Information
#
# Table name: volunteer_days
#
#  id              :integer         not null, primary key
#  day_id          :integer
#  entry_id :integer
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#

