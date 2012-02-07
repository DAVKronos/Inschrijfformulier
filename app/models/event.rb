class Event < ActiveRecord::Base
  belongs_to :category
end
# == Schema Information
#
# Table name: events
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  category_id :integer
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

