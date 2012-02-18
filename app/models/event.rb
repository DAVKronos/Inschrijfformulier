class Event < ActiveRecord::Base
  belongs_to :sex
  has_many :event_participations, :dependent => :destroy
  has_many :entries, :through => :event_participations
end
# == Schema Information
#
# Table name: events
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  sex_id      :integer
#  time_format :boolean
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

