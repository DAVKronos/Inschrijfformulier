class Registration < ActiveRecord::Base
  belongs_to :sex
  belongs_to :club
  belongs_to :college
  has_many :event_participations
  has_many :events, :through => :event_participations
end
# == Schema Information
#
# Table name: registrations
#
#  id                :integer         not null, primary key
#  name              :string(255)
#  birthdate         :string(255)
#  sex_id            :integer
#  club_id           :integer
#  licensenumber     :string(255)
#  college_id        :integer
#  studentnumber     :string(255)
#  email             :string(255)
#  banknumber        :string(255)
#  bankAccountName   :string(255)
#  bankLocation      :string(255)
#  bankAuthorization :boolean
#  created_at        :datetime        not null
#  updated_at        :datetime        not null
#  study             :string(255)
#  volunteer         :string(255)
#

