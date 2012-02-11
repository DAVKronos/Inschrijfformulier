class Registration < ActiveRecord::Base
  belongs_to :sex
  belongs_to :club
  belongs_to :college
  has_many :event_participations, :dependent => :destroy
  has_many :events, :through => :event_participations
  
  attr_writer :current_step
  
  validates :name, :email, :presence => true
  
  def current_step
    @current_step || steps.first
  end

  def steps
    %w[general participation athlete volunteer secondaries payment confirmation]
  end

  def next_step
    self.current_step = steps[steps.index(current_step)+1]
  end

  def previous_step
    self.current_step = steps[steps.index(current_step)-1]
  end

  def first_step?
    current_step == steps.first
  end

  def last_step?
    current_step == steps.last
  end

  def all_valid?
    steps.all? do |step|
      self.current_step = step
      valid?
    end
  end
end
# == Schema Information
#
# Table name: registrations
#
#  id                   :integer         not null, primary key
#  name                 :string(255)
#  birthdate            :date
#  sex_id               :integer
#  club_id              :integer
#  licensenumber        :string(255)
#  college_id           :integer
#  studentnumber        :string(255)
#  email                :string(255)
#  banknumber           :string(255)
#  bankAccountName      :string(255)
#  bankLocation         :string(255)
#  bankAuthorization    :boolean
#  meetRegulations      :boolean
#  zeusDatabase         :boolean
#  diner                :boolean
#  party                :boolean
#  shirtsize            :string(255)
#  volunteerPreferences :string(255)
#  volunteerSkills      :string(255)
#  created_at           :datetime        not null
#  updated_at           :datetime        not null
#  study                :string(255)
#

