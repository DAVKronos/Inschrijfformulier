class AddVolunteerToRegistration < ActiveRecord::Migration
  def change
    add_column :registrations, :volunteer, :string

  end
end
