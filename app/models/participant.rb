class Participant < ActiveRecord::Base
  has_one :entry, :dependent => :destroy
  has_many :authentications, :dependent => :destroy
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  
  def apply_omniauth(omniauth)
    authentications.build(:provider => omniauth['provider'], :uid => omniauth['uid'])
  end
  
  def password_required?
    (authentications.empty? || !password.blank?) && super
  end
  
  def facebook(token)
    @fb_user ||= FbGraph::User.me(token)
  end
  
  def publish(text, feed_name, token)

    facebook(token).feed!(:message => text, :name => feed_name)


    #rescue Exception => e
  end

end
