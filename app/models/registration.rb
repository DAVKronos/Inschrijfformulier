class Registration < ActiveRecord::Base
  belongs_to :sex
  belongs_to :club
  belongs_to :college
  has_many :event_participations, :dependent => :destroy
  has_many :events, :through => :event_participations
  has_many :volunteer_days, :dependent => :destroy
  has_many :days, :through => :volunteer_days
  
  attr_writer :current_step
  
  validates :name, :email, :presence => true
  
  def current_step
    @current_step || steps.first
  end

  def steps
    returnArray = %w[general participation]
    if self.athlete?
      returnArray += %w[athlete]
    elsif self.volunteer?
      returnArray += %w[volunteer]
    end
    returnArray += %w[secondaries]
    if self.mustPay?
      returnArray += %w[payment]
    end
    returnArray += %w[confirmation]
    
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
  
  def volunteer?
    self.days.size > 0
  end
  
  def athlete?
    self.events.size > 0
  end
  
  def mustPay?
  end
  
  def totalCost
    returnCost = 0
    if diner
      returnCost += self.dinerCost
    end
    if party
      returnCost += self.partyCost
    end
    if shirtsize != ""
      returnCost += self.shirtCost
    end
    returnCost
  end
  
  def dinerCost
    if self.volunteer?
      0
    else
      10
    end
      
  end
  
  def partyCost
    10
  end
  
  def shirtCost
    returnCost = 10
    if self.volunteer?
      returnCost = 0
    end
    returnCost
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

