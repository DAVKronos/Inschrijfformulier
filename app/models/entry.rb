class Entry < ActiveRecord::Base
  serialize :volunteerPreferences, Hash
  belongs_to :sex
  belongs_to :club
  belongs_to :college
  belongs_to :participant
  has_many :event_participations, :dependent => :destroy
  has_many :events, :through => :event_participations
  has_many :volunteer_days, :dependent => :destroy
  has_many :days, :through => :volunteer_days
  accepts_nested_attributes_for :event_participations
  validates_associated :event_participations
  
  
  attr_writer :current_step
  name_regex = /\A[A-Z].*\z/
  banknumber_regex = /\A\d{6,9}\z/
  
  validates_presence_of :name, :if => lambda { |o| o.current_step == "general" }
  validates_format_of :name, :with => name_regex, :if => lambda { |o| o.current_step == "general" }
  validates_presence_of :meetRegulations, :if => lambda { |o| o.current_step == "confirmation" && o.athlete? }
  validates_presence_of :bankAuthorization, :if => lambda { |o| o.current_step == "confirmation" && o.mustPay? }
  validates_presence_of :licensenumber, :study, :studentnumber, :club_id, :college_id, :birthdate, :if => lambda { |o| o.current_step =="athlete" }
  validates_presence_of :event_participations, :if => lambda { |o| o.current_step == "participation" && !o.volunteer? }
  validates_presence_of :day_ids, :if => lambda { |o| o.current_step == "participation" && !o.athlete? }
  validates_presence_of :banknumber, :bankLocation, :bankAccountName, :if => lambda { |o| o.current_step == "payment"}
  validates_format_of :banknumber, :with => banknumber_regex, :message => "vul 6 tot 9 getallen in", :if => lambda { |o| o.current_step == "payment"}
  validates_uniqueness_of :participant_id
  
  
  
  
  def current_step
    @current_step || steps.first
  end

  def steps
    returnArray = %w[general participation]
    if self.athlete?
      returnArray += %w[athlete]
    end
    if self.volunteer?
      returnArray += %w[volunteer]
    end
    returnArray += %w[secondaries]
    if self.mustPay?
      returnArray += %w[payment]
    end
    returnArray += %w[confirmation]
    
  end
  
  def self.serialized_attr_accessor(*args)
    args.each do |method_name|
      eval "
        def #{method_name}
          (self.volunteerPreferences || {})[:#{method_name}]
        end
        def #{method_name}=(value)
          self.volunteerPreferences ||= {}
          self.volunteerPreferences[:#{method_name}] = value
        end
      "
    end
  end

  serialized_attr_accessor :onderdeel_voorkeuren, :jureren, :materiaalploeg, :catering, :jury_algemeen, :jury_tijd, :jury_scheidsrechter, :meldbureau, :wedstrijdsec, :tshirtmaat

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
    self.event_participations.size > 0
  end
  
  def mustPay?
    self.totalCost > 0
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
    if athlete?
      returnCost += (6 + 4*(event_participations.size-1))
    end
    returnCost
  end
  
  def dinerCost
    returnCost = 0
    if !self.volunteer?
      returnCost = 7.50
    end
    returnCost
  end
  
  def partyCost
    5.00
  end
  
  def shirtCost
    12.00
  end
  
  # ===============
  # = CSV support =
  # ===============
  
  comma do
    
    name 'Naam'
    sex :name => 'Geslacht'
    licensenumber 'Licentienummer'
    college :name => 'OnderwijsInstelling'
    study 'Studie'
    studentnumber 'Studentnummer'
    banknumber 'Rekeningnummer'
    bankAccountName 'Naam Rekeninghouder'
    bankLocation 'Plaats bank'
    totalCost 'Totale kosten'
    zeusDatabase 'zeus database'
    participant :email => 'E-mail'
    diner
    party
    shirtsize 'Maat t-shirt'
    volunteerPreferences
    
  end
end
# == Schema Information
#
# Table name: entries
#
#  id                   :integer         not null, primary key
#  name                 :string(255)
#  birthdate            :date
#  sex_id               :integer
#  club_id              :integer
#  licensenumber        :string(255)
#  college_id           :integer
#  participant_id       :integer
#  studentnumber        :string(255)
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
#  auth_hash            :string(255)
#  created_at           :datetime        not null
#  updated_at           :datetime        not null
#  study                :string(255)
#

